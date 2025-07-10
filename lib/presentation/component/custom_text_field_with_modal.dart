import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CustomBottomChoiceOrInput extends StatefulWidget {
  final String header;
  final String hintText;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? textController;
  final void Function()? onTap;

  const CustomBottomChoiceOrInput({
    super.key,
    required this.header,
    required this.hintText,
    this.onFieldSubmitted,
    this.textController,
    this.onTap,
  });

  @override
  State<CustomBottomChoiceOrInput> createState() =>
      _CustomBottomChoiceOrInputState();
}

class _CustomBottomChoiceOrInputState extends State<CustomBottomChoiceOrInput> {
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
          GestureDetector(
            onTap: () => widget.onTap!(),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.lightGrey,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                (widget.textController?.text.isNotEmpty ?? false)
                    ? widget.textController!.text
                    : widget.hintText,
                style: TextStyle(
                  color: (widget.textController?.text.isNotEmpty ?? false)
                      ? Colors.black
                      : Colors.black.withOpacity(0.5),
                  fontSize: 14.sp,
                  fontFamily: 'Satoshi',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
