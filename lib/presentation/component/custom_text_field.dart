import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String header;
  final String hintText;
  final bool isPassword;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextEditingController? textController;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.header,
    this.textController,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withOpacity(0.4),
        selectionHandleColor: AppColors.primary,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.header,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            onFieldSubmitted: (value) {
              widget.onFieldSubmitted != null
                  ? widget.onFieldSubmitted!(value)
                  : null;
            },
            validator: widget.validator,
            controller: widget.textController,
            obscureText: widget.isPassword && !isPasswordVisible,
            cursorColor: AppColors.primary,
            selectionControls: materialTextSelectionControls,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: AppColors.lightGrey,
                fontFamily: 'Satoshi',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: AppColors.primary, width: 1.5.w)),
              alignLabelWithHint: false,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    )
                  : null,
            ),
            keyboardType: widget.isPassword
                ? TextInputType.visiblePassword
                : TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
