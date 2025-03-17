import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CustomDropdownForm extends StatefulWidget {
  final String header;
  final Function onCategoryChanged;
  final String hintText;
  final List<String> listDropdown;
  final TextEditingController textEditingController;

  const CustomDropdownForm({
    super.key,
    required this.header,
    required this.onCategoryChanged,
    required this.textEditingController,
    required this.listDropdown,
    required this.hintText,
  });

  @override
  State<CustomDropdownForm> createState() =>
      _CustomDropdownFormState();
}

class _CustomDropdownFormState extends State<CustomDropdownForm> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 16.h),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
          ),
          hint: Text(
            widget.hintText,
            style: TextStyle(fontSize: 14.sp, color: AppColors.lightGrey),
          ),
          items: widget.listDropdown
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
              return 'Kategori surat.';
            }
            return null;
          },
          onChanged: (String? value) {
            if (value != null) {
              widget.textEditingController.text = value;
              setState(() {
                selectedValue = value;
              });
            } else {
              widget.textEditingController.clear();
            }
          },
          onSaved: (value) {
            selectedValue = value.toString();
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          ),
          menuItemStyleData: MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16.w)),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
