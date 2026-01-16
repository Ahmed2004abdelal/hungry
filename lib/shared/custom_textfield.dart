import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/constant/app_color.dart';

class CustomTextfield extends StatefulWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? vali;

  const CustomTextfield({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
    required this.vali,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.prim,
      cursorHeight: 20,
      controller: widget.controller,
      validator: widget.vali,
      obscureText: widget.isPassword && _obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? Icon(CupertinoIcons.eye_slash)
                    : Icon(CupertinoIcons.eye),
              )
            : null,
        hintText: widget.hint,

        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
