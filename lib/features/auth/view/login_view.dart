import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/network/api_error.dart';
import '../data/auth_repo.dart';
import 'signup_view.dart';
import '../widget/custom_auth_button.dart';
import '../../../root.dart';
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textfield.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    emailController.text = "omar2017@gmail.com";
    passController.text = "123123123";
    super.initState();
  }

  void navigate(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => page));
  }

  Future<void> login() async {
    setState(() => isLoading = true);
    try {
      final user = await authRepo.login(
        emailController.text.trim().toLowerCase(),
        passController.text.trim().toLowerCase(),
      );
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (c) => Root()));
      }
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      late String errorMsg;
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

        // ✅ الحل هنا
        resizeToAvoidBottomInset: true, // يسمح بتحريك المحتوى مع الكيبورد

        body: SafeArea(
          // ✅ نضيف SingleChildScrollView لتفادي أي Overflow
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Gap(100),

                    // اللوجو
                    SvgPicture.asset(
                      "assets/logo/Hungry.svg",
                      color: AppColor.prim,
                    ),
                    const Gap(5),

                    const CustomText(
                      title: "Welcome Back, Discover The Fast Food",
                      size: 13,
                      weight: FontWeight.w500,
                      colors: Colors.black54,
                    ),
                    const Gap(50),

                    // form
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.fromLTRB(10, 40, 10, 25),
                            decoration: BoxDecoration(
                              color: AppColor.prim.withOpacity(0.3), // الشفافية
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColor.prim.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    // email
                                    CustomTextfield(
                                      hint: "Email Address",
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

                                    // password
                                    CustomTextfield(
                                      hint: "Password",
                                      isPassword: true,
                                      controller: passController,
                                      vali: (v) {
                                        if (v == null || v.isEmpty) {
                                          return "Please enter your password";
                                        }
                                        if (v.length < 6) {
                                          return "Password must be at least 6 characters";
                                        }
                                        return null;
                                      },
                                    ),
                                    const Gap(15),

                                    // login button
                                    isLoading
                                        ? const CupertinoActivityIndicator(
                                            radius: 20,
                                            color: Colors.white,
                                          )
                                        : CustomAuthButton(
                                            text: "Login",
                                            color: AppColor.prim,
                                            textColor: Colors.white,
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                login();
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

                                    // signup & guest
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomAuthButton(
                                          width: 145,
                                          text: "Signup",
                                          onTap: () =>
                                              navigate(context, SignupView()),
                                        ),
                                        CustomAuthButton(
                                          width: 145,
                                          text: "Guest",
                                          onTap: () =>
                                              navigate(context, Root()),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ✅ حافظنا على الـ Spacer
                    const Spacer(),
                    CustomText(
                      title: "©2025 3ab3al. All Rights Reserved",
                      size: 11,
                      weight: FontWeight.bold,
                      colors: AppColor.prim.withAlpha(150),
                    ),
                    const Gap(60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
