import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/upload/upload_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_datepicker.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/dropdown_form.dart';
import 'package:tracking_apps/presentation/component/pdf_upload.dart';

part 'upload_mixin.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with UploadMixin {
  late String? _authToken;

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
  }

  Future<void> _loadAuthToken() async {
    final token = await SharedPreferencesService.instance
        .getData<String>(PreferenceKey.authToken);
    setState(() {
      _authToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UploadBloc _uploadBloc = BlocProvider.of<UploadBloc>(context);
    return BlocListener<UploadBloc, UploadState>(
      listener: (context, state) {
        _listener(state);
      },
      child: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.whitePage,
              appBar: _appBar(),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Surat Izin',
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
                    CustomTextField(
                      textController: _descriptionTextEditingController,
                      hintText: 'Masukan deskripsi surat izin',
                      header: 'Uraian',
                      onFieldSubmitted: (value) {
                        _submit(_uploadBloc);
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomTextField(
                      textController: _noPermitTextEditingController,
                      hintText: 'Masukan nomor surat',
                      header: 'No. Surat',
                      onFieldSubmitted: (value) {
                        _submit(_uploadBloc);
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomDatePicker(
                      initialDateTime: _dateTextEditingController,
                      header: 'Tanggal Masuk Berkas',
                      hintText: 'Ex. 14-01-2025',
                      onDateSelected: (date) {
                        setState(() {
                          _dateTextEditingController = date;
                        });
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomTextField(
                      textController: _companyNameTextEditingController,
                      hintText: 'Masukan nama perusahaan',
                      header: 'Nama Perusahaan',
                      onFieldSubmitted: (value) {
                        _submit(_uploadBloc);
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomTextField(
                      textController: _noPermitMabesEditingController,
                      hintText: 'Masukan nomor surat',
                      header: 'Nomor Surat Mabes',
                      onFieldSubmitted: (value) {
                        _submit(_uploadBloc);
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    DropdownForm(
                      header: 'Kategori',
                      onCategoryChanged: (value) {
                        _submit(_uploadBloc);
                        print('============= INI NULL =============');
                      },
                      textEditingController:
                          _categoryPermitTextEditingController,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    buildPdfPicker(),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      text: 'Unggah Surat',
                      onPressed: () {
                        AppHelper.alertDialogMessage(
                            context: context,
                            content:
                                'Are you sure you want to upload this document?',
                            onPressed: () {
                              _submit(_uploadBloc);
                              Navigator.pop(context);
                            });
                      },
                      isLogOut: false,
                      isLoading: state.isLoading,
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'Pengunggahan Surat Izin',
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        fontFamily: 'Satoshi',
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
