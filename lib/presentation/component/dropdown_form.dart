import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class DropdownForm extends StatelessWidget {
  final String header;
  final List<String> statusTahapan = [
    'Dalam proses',
    'Terverifikasi',
    'Tanda Tangan',
    'Di tolak'
  ];

  String? selectedValue;
  final _formKey = GlobalKey<FormState>();

  DropdownForm({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 16.h),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
          ),
          hint: Text(
            'Pilih status',
            style: TextStyle(fontSize: 14.sp, color: AppColors.lightGrey),
          ),
          items: statusTahapan
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              )
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Pilih Status.';
            }
            return null;
          },
          onChanged: (value) {},
          onSaved: (value) {
            selectedValue = value.toString();
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r)
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16.w)
          ),
        ),
        SizedBox(height: 30.h,),

      ],
    );
  }
}
