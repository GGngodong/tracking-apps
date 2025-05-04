import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CustomDatePicker extends StatefulWidget {
  final String header;
  final String hintText;
  final DateTime? initialDateTime;
  final Function(DateTime)? onDateSelected;

  const CustomDatePicker(
      {super.key,
      required this.header,
      required this.hintText,
      this.onDateSelected,
      this.initialDateTime});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    selectedDate = widget.initialDateTime ?? DateTime.now();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: const Locale('id', 'ID'),
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      final String formattedDate = DateFormat('dd-MM-yyyy').format(picked);

      if (widget.onDateSelected != null) {
        widget.onDateSelected!(DateTime(picked.year, picked.month, picked.day));
      }
      print("Selected date: $picked");
      print("Selected date (formatted): $formattedDate");
    }
  }

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
            onTap: () => _selectDate(context),
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
                selectedDate != null
                    ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                    : widget.hintText,
                style: TextStyle(
                  color:
                      selectedDate != null ? Colors.black : AppColors.lightGrey,
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
