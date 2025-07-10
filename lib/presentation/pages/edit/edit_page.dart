import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/detail/get_detail_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/edit/edit_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_bottom_choice_chip.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/custom_text_field_with_modal.dart';
import 'package:tracking_apps/presentation/component/dropdown_form_status_tahapan.dart';
import 'package:tracking_apps/presentation/component/pdf_upload.dart';

part 'edit_mixin.dart';

class EditPage extends StatefulWidget {
  final String id;

  const EditPage({super.key, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> with EditMixin {
  String _firstValue = '';
  String _secondValue = '';
  String _thirdValue = '';

  @override
  Widget build(BuildContext context) {
    final EditBloc editBloc = BlocProvider.of<EditBloc>(context);
    return BlocListener<EditBloc, EditState>(
      listener: (context, state) {
        _listener(state);
      },
      child: BlocBuilder<EditBloc, EditState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.whitePage,
            appBar: _appBar(),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Surat Izin',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomDropdownForm(
                    hintText: 'Status Tahapan',
                    header: 'Proses Tahapan',
                    onCategoryChanged: (value) {
                      _submit(editBloc);
                    },
                    textEditingController: _statusProcessTextEditingController,
                    listDropdown: [
                      'Verifikasi 1',
                      'Submit',
                      'Draft',
                      'Penelitian Dokumen',
                      'Verifikasi 2',
                      'Verifikasi 3',
                      'Approval',
                      'Penomoran',
                      'Release'
                    ],
                  ),
                  CustomDropdownForm(
                    hintText: 'Status',
                    header: 'Upload Status',
                    onCategoryChanged: (value) {
                      _submit(editBloc);
                    },
                    textEditingController: _uploadStatusTextEditingController,
                    listDropdown: ['PENDING', 'REJECTED', 'APPROVED'],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomTextField(
                    hintText: 'No. SI Mabes',
                    header: 'No. SI TERBIT',
                    textController: _noPermitMabesTextEditingController,
                    onFieldSubmitted: (value) {
                      _submit(editBloc);
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomBottomChoiceOrInput(
                    header: 'Tambahkan catatan',
                    hintText: 'Catatan',
                    textController: _noteTextEditingController,
                    onTap: () async {
                      final result =
                          await showModalBottomSheet<Map<String, String>>(
                        context: context,
                        enableDrag: true,
                        backgroundColor: Colors.white,
                        showDragHandle: true,
                        isDismissible: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.r)),
                        ),
                        builder: (context) => CustomBottomChoiceChip(
                          initialFirstValue: _firstValue,
                          initialSecondValue: _secondValue,
                          initialThirdValue: _thirdValue,
                          choices: [
                            'Dokumen tidak Lengkap',
                            'Nama tidak sesuai',
                            'Jumlah Tidak Sesuai',
                            'Lainnya'
                          ],
                        ),
                      );
                      if (result == null) return;

                      final pickedValues = [
                        result['firstValue'],
                        result['secondValue'],
                        result['thirdValue'],
                      ];
                      final hasOther = pickedValues.any((v) => v == 'Lainnya');
                      if (hasOther) {
                        final otherController = TextEditingController();
                        final otherText = await showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding:
                                EdgeInsets.symmetric(horizontal: 16.w),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Masukkan catatan Anda di bawah ini:',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Satoshi',
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  TextField(
                                    controller: otherController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan catatan Anda...',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(null),
                                          child: Text(
                                            'Batal',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Satoshi',
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                          onPressed: () => Navigator.of(context)
                                              .pop(otherController.text),
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Satoshi',
                                            ),
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        );

                        if (otherText != null && otherText.trim().isNotEmpty) {
                          setState(() {
                            _noteTextEditingController.text = otherText.trim();
                          });
                        }
                      } else {
                        setState(() {
                          _firstValue = result['firstValue']!;
                          _secondValue = result['secondValue']!;
                          _thirdValue = result['thirdValue']!;
                          _noteTextEditingController.text =
                              '1. $_firstValue\n2. $_secondValue\n3. $_thirdValue';
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  buildPdfPicker(),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomButton(
                    text: 'Edit Dokumen',
                    onPressed: () {
                      if (_statusProcessTextEditingController.text
                          .trim()
                          .isEmpty) {
                        AppHelper.showCustomAlertDialog(
                          context: context,
                          title: 'Bagian ini harus di isi!',
                          content: 'Silahkan pilih proses tahapan.',
                          onPositivePressed: () => Navigator.pop(context),
                        );
                        return;
                      }
                      if (_uploadStatusTextEditingController.text
                          .trim()
                          .isEmpty) {
                        AppHelper.showCustomAlertDialog(
                          context: context,
                          title: 'Bagian ini harus di isi!',
                          content: 'Silahkan pilih status.',
                          onPositivePressed: () => Navigator.pop(context),
                        );
                        return;
                      }
                      AppHelper.showCustomAlertDialog(
                        context: context,
                        title: 'Edit Dokumen',
                        content: 'Are you sure want to edit this document?',
                        onPositivePressed: () {
                          _submit(editBloc);
                          Navigator.of(context).pop();
                        },
                        onNegativePressed: () => Navigator.of(context).pop(),
                        negativeButtonText: 'Cancel',
                      );
                    },
                    isLogOut: false,
                    isLoading: state.isLoading,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Edit',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: headerAppBar),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
