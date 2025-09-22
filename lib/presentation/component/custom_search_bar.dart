import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

enum TypeSearchBar { regular, withClear, withDropdownFilter }

class CustomSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  EdgeInsets? margin = EdgeInsets.zero;
  Color? iconColor = AppColors.lightGrey;
  bool? openKeyboard = false;
  final Function(String)? isSubmitted;
  final Function(String)? onChanged;
  final String hintText;
  final List<BoxShadow>? boxShadowList;
  final List<String> items;
  final TypeSearchBar searchType;

  CustomSearchBar(
      {this.margin,
      this.iconColor,
      this.controller,
      this.isSubmitted,
      this.onChanged,
      this.boxShadowList,
      required this.hintText,
      required this.searchType,
      required this.items,
      super.key});

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: widget.boxShadowList ??
            [
              const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: Offset(0, 2),
                blurRadius: 6,
              )
            ],
      ),
      child: CupertinoTextField(
        style: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14.sp,
        ),
        controller: widget.controller,
        autofocus: widget.openKeyboard ?? false,
        onSubmitted: widget.isSubmitted,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        placeholder: widget.hintText,
        placeholderStyle: TextStyle(
          color: AppColors.lightGrey,
          fontSize: 14.sp,
          fontFamily: 'Satoshi',
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        prefix: searchBarPrefix(widget.searchType),
        suffix: searchBarSuffix(widget.searchType),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget searchBarPrefix(TypeSearchBar searchType) {
    switch (searchType) {
      case TypeSearchBar.regular:
        return Container(
          margin: EdgeInsets.only(left: 20.w),
          child: Image.asset('assets/icons/search.png',
              width: 20.sp, color: widget.iconColor ?? AppColors.lightGrey),
        );
      case TypeSearchBar.withDropdownFilter:
        return Container(
          margin: EdgeInsets.only(left: 20.w),
          child: Image.asset('assets/icons/search.png',
              width: 20.sp, color: widget.iconColor ?? AppColors.lightGrey),
        );
      default:
        return const SizedBox();
    }
  }

  Widget searchBarSuffix(TypeSearchBar searchType) {
    switch (searchType) {
      case TypeSearchBar.withClear:
        return Container(
          margin: EdgeInsets.only(right: 20.w),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              (widget.controller)!.clear();
            },
            icon: Icon(
              Icons.clear,
              color: widget.iconColor ?? AppColors.lightGrey,
              size: 20.sp,
            ),
          ),
        );

      case TypeSearchBar.withDropdownFilter:
        return Container(
          margin: EdgeInsets.only(right: 10.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              value: selectedValue,
              hint: Row(
                children: [
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(31, 41, 55, 1),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              buttonStyleData: ButtonStyleData(
                height: 41.h,
                width: 150.w,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.expand_more_rounded),
                iconSize: 20,
                iconEnabledColor: Color.fromRGBO(102, 112, 133, 1),
                iconDisabledColor: AppColors.lightGrey,
                openMenuIcon: Icon(Icons.expand_less_rounded),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color.fromRGBO(208, 213, 221, 1),
                  ),
                ),
              ),
              items: widget.items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(16, 24, 40, 1),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return widget.items.map<Widget>((item) {
                  return Row(
                    children: [
                      const VerticalDivider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(16, 24, 40, 1),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }
}
