import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

import 'custom_button.dart';

class CustomBottomChoiceChip extends StatefulWidget {
  final String initialFirstValue;
  final String initialSecondValue;
  final String initialThirdValue;
  final List<String> choices;

  const CustomBottomChoiceChip({
    super.key,
    required this.choices,
    this.initialFirstValue = '',
    this.initialSecondValue = '',
    this.initialThirdValue = '',
  });

  @override
  State<CustomBottomChoiceChip> createState() => _CustomBottomChoiceChipState();
}

class _CustomBottomChoiceChipState extends State<CustomBottomChoiceChip> {
  List<String> selectedValues = [];

  @override
  void initState() {
    super.initState();
    selectedValues = [
      widget.initialFirstValue,
      widget.initialSecondValue,
      widget.initialThirdValue,
    ].where((value) => value.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Note',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedValues.clear();
                        });
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: AppColors.tertiary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: widget.choices.map((choice) {
                        return ChoiceChip(
                          label: Text(choice),
                          selectedColor: AppColors.tertiary,
                          backgroundColor: Colors.white,
                          showCheckmark: true,
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Satoshi',
                          ),
                          selected: selectedValues.contains(choice),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                if (selectedValues.length < 3) {
                                  selectedValues.add(choice);
                                }
                              } else {
                                selectedValues.remove(choice);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      text: 'Save',
                      onPressed: () {
                        Navigator.pop(context, {
                          'firstValue': selectedValues.isNotEmpty
                              ? selectedValues[0]
                              : '',
                          'secondValue': selectedValues.length >= 2
                              ? selectedValues[1]
                              : '',
                          'thirdValue': selectedValues.length >= 3
                              ? selectedValues[2]
                              : '',
                        });
                      },
                      isLogOut: false,
                    ),
                    SizedBox(height: 20.h)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
