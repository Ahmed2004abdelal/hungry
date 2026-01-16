import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textfield.dart';
import '../data/auth_repo.dart';
import '../widget/custom_auth_button.dart';
import 'login_view.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  bool isLoading = false;

  void navigate(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => page));
  }

  final AuthRepo authRepo = AuthRepo();

  Future<void> signup(context) async {
    setState(() => isLoading = true);
    try {
      final user = await authRepo.signup(
        nameController.text.trim().toLowerCase(),
        emailController.text.trim().toLowerCase(),
        passController.text.trim().toLowerCase(),
        confirmPassController.text.trim().toLowerCase(),
      );
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginView()));
        // ScaffoldMessenger.of(context).showSnackBar(customSnack("login now",));
      }
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      String errorMsg = "Error in signup";
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                // ده بيخلي المحتوى يوسع على قد الشاشة أو الكيبورد
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const Gap(90),

                        SvgPicture.asset(
                          "assets/logo/Hungry.svg",
                          color: AppColor.prim,
                        ),
                        const Gap(5),

                        const CustomText(
                          title: "Create Your Account and Join Hungry!",
                          size: 13,
                          weight: FontWeight.w500,
                          colors: Colors.black54,
                        ),
                        const Gap(50),

                        // form
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                  10,
                                  40,
                                  10,
                                  25,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.prim.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColor.prim.withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: Form(
                                  key: _key,
                                  child: Column(
                                    children: [
                                      CustomTextfield(
                                        hint: 'Name',
                                        isPassword: false,
                                        controller: nameController,
                                        vali: (v) {
                                          if (v == null || v.trim().isEmpty) {
                                            return "Please enter your name";
                                          }
                                          return null;
                                        },
                                      ),
                                      const Gap(10),
                                      CustomTextfield(
                                        hint: 'Email Address',
                                        isPassword: false,
                                        controller: emailController,
                                        vali: (v) {
                                          if (v == null || v.trim().isEmpty) {
                                            return "Please enter your email";
                                          }
                                          if (!v.contains("@") ||
                                              !v.contains(".")) {
                                            return "Please enter a valid email address";
                                          }
                                          return null;
                                        },
                                      ),
                                      const Gap(10),
                                      CustomTextfield(
                                        hint: 'Password',
                                        isPassword: true,
                                        controller: passController,
                                        vali: (v) {
                                          if (v == null || v.isEmpty) {
                                            return "Please enter a password";
                                          }
                                          if (v.length < 6) {
                                            return "Password must be at least 6 characters";
                                          }
                                          return null;
                                        },
                                      ),
                                      const Gap(10),
                                      CustomTextfield(
                                        hint: 'Confirm Password',
                                        isPassword: true,
                                        controller: confirmPassController,
                                        vali: (v) {
                                          if (v == null || v.isEmpty) {
                                            return "Please confirm your password";
                                          }
                                          if (v != passController.text) {
                                            return "Passwords do not match";
                                          }
                                          return null;
                                        },
                                      ),
                                      const Gap(15),

                                      isLoading
                                          ? CupertinoActivityIndicator()
                                          : CustomAuthButton(
                                              text: "Sign Up",
                                              color: AppColor.prim,
                                              textColor: Colors.white,
                                              onTap: () async {
                                                if (_key.currentState!
                                                    .validate()) {
                                                  await signup(context);
                                                } else {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    customSnack(
                                                      "Please fix the errors above.",
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                      const Gap(10),
                                      CustomAuthButton(
                                        text: "Already have an account?",
                                        onTap: () =>
                                            navigate(context, LoginView()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),
                        CustomText(
                          title: "©2025 3ab3al. All Rights Reserved",
                          size: 11,
                          weight: FontWeight.bold,
                          colors: AppColor.prim.withAlpha(150),
                        ),
                        const Gap(30),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
