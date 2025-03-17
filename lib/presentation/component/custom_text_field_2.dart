import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CustomTextField2 extends StatelessWidget {
  final String header;
  final String hintText;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? textController;

  const CustomTextField2({
    super.key,
    required this.header,
    required this.hintText,
    this.onFieldSubmitted,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primary,
          selectionColor: AppColors.primary.withOpacity(0.4),
          selectionHandleColor: AppColors.primary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
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
              onFieldSubmitted != null ? onFieldSubmitted!(value) : null;
            },
            maxLines: 3,
            scrollPhysics: const BouncingScrollPhysics(),
            controller: textController,
            cursorColor: AppColors.primary,
            selectionControls: materialTextSelectionControls,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.lightGrey,
                fontFamily: 'Satoshi',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5.w,
                ),
              ),
              alignLabelWithHint: false,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
