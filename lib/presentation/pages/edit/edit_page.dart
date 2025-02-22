import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/detail/get_detail_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/edit/edit_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_bottom_choice_chip.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/custom_text_field_with_modal.dart';
import 'package:tracking_apps/presentation/component/dropdown_form_status_tahapan.dart';

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
                      'Submitted',
                      'Verification 1',
                      'Draft',
                      'Research',
                      'Verification 2',
                      'Verification 3',
                      'Approval',
                      'Permit Numbering',
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
                    hintText: 'No. Produk Mabes',
                    header: 'Produk Mabes',
                    textController: _noPermitMabesTextEditingController,
                    onFieldSubmitted: (value) {
                      _submit(editBloc);
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomTextFieldWithModal(
                    header: 'Tambahkan catatan',
                    hintText: 'Catatan',
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
                            'Jumlah Tidak Sesuai'
                          ],
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          _firstValue = result['firstValue']!;
                          _secondValue = result['secondValue']!;
                          _thirdValue = result['thirdValue']!;
                          _noteTextEditingController.text =
                              '1. ${result['firstValue']}\n2. ${result['secondValue']}\n3. ${result['thirdValue']}';
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomButton(
                    text: 'Edit Dokumen',
                    onPressed: () {
                      _submit(editBloc);
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
