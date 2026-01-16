import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/network/api_error.dart';
import '../data/auth_repo.dart';
import '../data/user_model.dart';
import 'login_view.dart';
import 'signup_view.dart';
import '../widget/profile_text_field.dart';
import '../../home/view/home_view.dart';
import '../../product/view/product_details_view.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final TextEditingController _visa = TextEditingController();

  String? img;

  AuthRepo authRepo = AuthRepo();

  UserModel? usermodel;

  bool isloading = false;
  bool isloading2 = false;
  bool isguest = false;

  //* auto login
  Future<void> autologin() async {
    final user = await authRepo.autologin();
    setState(() => isguest = authRepo.isGuest);
    if (user != null)
      setState(() {
        usermodel = user;
      });
  }

  //*get profile data
  Future<void> getProgileData() async {
    try {
      final user = await authRepo.getProfileData();
      if (!mounted) return;
      setState(() => usermodel = user);
    } catch (e) {
      String erroerMessage = e.toString();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack(erroerMessage.toString()));
    }
  }

  @override
  void initState() {
    super.initState();
    if (usermodel == null) {
      getProgileData().then((_) {
        if (usermodel != null) {
          setState(() {
            _name.text = usermodel!.name;
            _email.text = usermodel!.email;
            _address.text = usermodel!.address ?? '';
            _visa.text = (usermodel!.visa == null || usermodel!.visa!.isEmpty)
                ? '1111 **** **** 2222'
                : usermodel!.visa!;
            img = usermodel!.image;
          });
        }
      });
    }
  }

  //* update profile data
  Future<void> updateProfileData() async {
    setState(() => isloading = true);
    try {
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        oldEmail: usermodel?.email,
        imagePath: img,
        visa: _visa.text.trim(),
      );
      if (!mounted) return;
      setState(() {
        // getProgileData();
        usermodel = user;
        isloading = false;
      });
      await getProgileData();
    } catch (e) {
      String errorMsg = " ";
      if (e is ApiError) errorMsg = e.message;
      setState(() => isloading = false);
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  //update img
  Future<void> updateImage() async {
    final pic = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pic != null) {
        img = pic.path;
      }
    });
  }

  //* logout
  Future<void> logout() async {
    setState(() => isloading2 = true);
    await authRepo.logout();
    setState(() => isloading2 = false);
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (c) => LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    if (!isguest) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.prim,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColor.prim,
            toolbarHeight: 30,
            leading: GestureDetector(
              onTap: () => Navigator.push(
                context,
                // MaterialPageRoute(builder: (c) => ProductDetailsView()),
                MaterialPageRoute(builder: (c) => HomeView()),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await getProgileData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  child: Skeletonizer(
                    enabled: usermodel == null || isloading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Gap(10),
                        //* image
                        Center(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: (img != null && File(img!).existsSync())
                                ? Image.file(File(img!), fit: BoxFit.cover)
                                : (usermodel?.image != null &&
                                      usermodel!.image!.startsWith("http") &&
                                      usermodel!.image!.isNotEmpty)
                                ? Image.network(
                                    usermodel!.image!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, err, builder) =>
                                        Icon(Icons.person, size: 90),
                                  )
                                : Icon(Icons.person, weight: 80),
                          ),
                        ),
                        Gap(10),

                        //* change image button
                        Center(
                          child: CustomButton(
                            title: "change image",
                            onTap: updateImage,
                            col: Colors.white,
                            textColor: AppColor.prim,
                            radius: BorderRadius.circular(50),
                            width: 150,
                            hight: 40,
                          ),
                        ),

                        Gap(20),
                        ProfileTextField(title: "Name", controller: _name),
                        Gap(20),
                        ProfileTextField(title: "Email", controller: _email),
                        Gap(20),
                        ProfileTextField(
                          title: "Address",
                          controller: _address,
                        ),
                        Gap(20),
                        Divider(),

                        _visa.text.isEmpty
                            ? ProfileTextField(
                                title: "ADD VISA CARD",
                                controller: _visa,
                                keyboardType: TextInputType.number,
                              )
                            : Material(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(13),
                                shadowColor: Colors.grey,
                                elevation: 6,
                                child: ListTile(
                                  onTap: () {},
                                  tileColor: const Color(0xffF3F4F6),
                                  leading: Image.asset(
                                    "assets/icon/visa.png",
                                    width: 50,
                                  ),
                                  title: const CustomText(
                                    title: "Debit card",
                                    colors: Colors.black,
                                    size: 11,
                                    weight: FontWeight.w400,
                                  ),

                                  subtitle: CustomText(
                                    title: _visa.text,
                                    size: 11,
                                    weight: FontWeight.w400,
                                    colors: AppColor.prim,
                                  ),
                                  trailing: Icon(
                                    Icons.done,
                                    color: AppColor.prim,
                                    size: 25,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomSheet: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade700,
                  spreadRadius: 5,
                  blurRadius: 20,
                ),
              ],
            ),
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isloading
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () {
                          updateProfileData();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.prim,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 45,
                          width: 120,
                          child: Row(
                            children: [
                              CustomText(
                                title: "Edit profile",
                                colors: Colors.white,
                              ),
                              Gap(10),
                              SvgPicture.asset(
                                "assets/icon/edit.svg",
                                color: Colors.white,
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColor.prim, width: 1),
                  ),
                  height: 45,
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          logout();
                        },
                        child: isloading2
                            ? CircularProgressIndicator()
                            : CustomText(
                                title: "Logout",
                                colors: AppColor.prim,
                                weight: FontWeight.bold,
                              ),
                      ),
                      Gap(10),
                      Icon(Icons.exit_to_app, color: AppColor.prim),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (isguest) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade700,
                spreadRadius: 5,
                blurRadius: 20,
              ),
            ],
          ),
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              isloading
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (c) => SignupView()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.prim,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 45,
                        width: 120,
                        child: Row(
                          children: [
                            CustomText(title: "signin", colors: Colors.white),
                          ],
                        ),
                      ),
                    ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColor.prim, width: 1),
                ),
                height: 45,
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (c) => LoginView()),
                        );
                      },
                      child: isloading2
                          ? CircularProgressIndicator()
                          : CustomText(
                              title: "logout",
                              colors: AppColor.prim,
                              weight: FontWeight.bold,
                            ),
                    ),
                    Gap(10),
                    Icon(Icons.exit_to_app, color: AppColor.prim),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
