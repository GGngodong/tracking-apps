import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget{
  final String hintText;
  final bool isPassword;
  const CustomTextField({super.key, required this.hintText, required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        suffixIcon: isPassword ? Icon(Icons.visibility_off) : null
      ),
    );
  }
}
