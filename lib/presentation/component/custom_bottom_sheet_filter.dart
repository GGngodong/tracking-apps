import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';

class CustomBottomSheetFilter extends StatefulWidget {
  final String initialCategory;
  final String initialSubCategory;

  const CustomBottomSheetFilter({
    super.key,
    this.initialCategory = '',
    this.initialSubCategory = '',
  });

  @override
  State<CustomBottomSheetFilter> createState() =>
      _CustomBottomSheetFilterState();
}

class _CustomBottomSheetFilterState extends State<CustomBottomSheetFilter> {
  late String selectedCategory;
  late String selectedSubCategory;

  final List<String> categories = ['OPS', 'DTU', 'DTM', 'DKK'];
  final List<String> subCategories = [
    '2P BARU',
    '3P BARU',
    'PENGGUNAAN SISA',
    'AHLI GUNA',
    'PEMUSNAHAN',
    '3P PERPANJANG',
    'PENGANGKUTAN ANTAR POLDA',
    '2P PERPANJANGAN',
    '3P PERPANJANGAN',
    'AHLI GUNA/HIBAH',
    'GUDANG',
    'GUDANG PERPANJANG',
    'RE-EKSPOR',
    'PENGGUNAAN/PROD. DI WIL PENGGUNA AKHIR',
    'IMPOR',
    'EKSPOR',
    'PEMBUATAN/PROD. HANDAK',
    'UJI COBA',
    'PEMBELIAN DAN PENGGUNAAN',
    'PENGGUNAAN',
    '3P',
    'BARU',
    'PERPANJANGAN',
    'ANGKUT SENPI DAN AMUNISI',
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    selectedSubCategory = widget.initialSubCategory;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 1.0,
      expand: true,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Urut Berdasarkan',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Satoshi'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedCategory = '';
                                selectedSubCategory = '';
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
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      Text(
                        'Divisi',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: categories.map((category) {
                          return ChoiceChip(
                            label: Text(category),
                            selected: selectedCategory == category,
                            selectedColor: AppColors.tertiary,
                            backgroundColor: Colors.white,
                            showCheckmark: true,
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                selectedCategory = selected ? category : '';
                              });
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Jenis Izin',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: subCategories.map((subCategory) {
                          return ChoiceChip(
                            label: Text(subCategory),
                            selected: selectedSubCategory == subCategory,
                            selectedColor: AppColors.tertiary,
                            backgroundColor: Colors.white,
                            showCheckmark: true,
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                selectedSubCategory =
                                    selected ? subCategory : '';
                              });
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        text: 'Cari Permohonan',
                        onPressed: () {
                          Navigator.pop(context, {
                            'category': selectedCategory,
                            'subCategory': selectedSubCategory,
                          });
                        },
                        isLogOut: false,
                      ),
                      SizedBox(height: 20.h)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
