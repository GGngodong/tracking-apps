import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomSheetFilter extends StatefulWidget {
  const CustomBottomSheetFilter({super.key});

  @override
  State<CustomBottomSheetFilter> createState() =>
      _CustomBottomSheetFilterState();
}

class _CustomBottomSheetFilterState extends State<CustomBottomSheetFilter> {
  String? _selectedCategory;
  String? _selectedSubCategory;

  final List<String> _categories = ['OPS', 'DTU', 'DTM', 'DKK'];
  final List<String> _subCategories = [
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
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
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
                        'Urut Berdasarkan',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _categories.map((category) {
                          return ChoiceChip(
                            label: Text(category),
                            selected: _selectedCategory == category,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedCategory = selected ? category : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Subkategori',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _subCategories.map((subCategory) {
                          return ChoiceChip(
                            label: Text(subCategory),
                            selected: _selectedSubCategory == subCategory,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedSubCategory =
                                    selected ? subCategory : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      // Add extra bottom spacing if needed
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, {
                            'category': _selectedCategory ?? '',
                            'subCategory': _selectedSubCategory ?? '',
                          });
                        },
                        child: Text(
                          'Apply Filter',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                      SizedBox(height: 20.h),
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
