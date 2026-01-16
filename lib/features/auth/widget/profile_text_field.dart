import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const ProfileTextField({super.key, required this.title, required this.controller, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                cursorWidth: 1.5,
                keyboardType:keyboardType ,
                controller:controller ,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: title,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
              );
  }
}