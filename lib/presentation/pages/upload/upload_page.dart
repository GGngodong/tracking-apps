import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/helper/validator_helper.dart';
import 'package:tracking_apps/presentation/blocs/permit/upload/upload_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_datepicker.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/dropdown_form_status_tahapan.dart';
import 'package:tracking_apps/presentation/component/pdf_upload.dart';

part 'upload_mixin.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with UploadMixin {
  String? _authToken;
  late final ScaffoldMessengerState _scaffoldMessenger;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
  }

  Future<void> _loadAuthToken() async {
    final token = await SharedPreferencesService.instance
        .getData<String>(PreferenceKey.authToken);
    if (mounted) {
      setState(() {
        _authToken = token;
      });
    }
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
                      validateOnChange: true,
                      validator: ValidatorHelper.validateDescription,
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
                      validateOnChange: true,
                      validator: ValidatorHelper.validatePermitNumber,
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
                      validateOnChange: true,
                      validator: ValidatorHelper.validateCompanyName,
                      onFieldSubmitted: (value) {
                        _submit(_uploadBloc);
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomDropdownForm(
                      hintText: 'Pilih Divisi',
                      header: 'Divisi',
                      onCategoryChanged: (value) {
                        _submit(_uploadBloc);
                      },
                      textEditingController:
                          _categoryPermitTextEditingController,
                      listDropdown: ['LOG.', 'DTU', 'DM/GM', 'DKK'],
                    ),
                    CustomDropdownForm(
                      hintText: 'Pilih Jenis Izin',
                      header: 'Jenis Izin',
                      onCategoryChanged: (value) {
                        _submit(_uploadBloc);
                      },
                      textEditingController:
                          _categoryAdministrationTextEditingController,
                      listDropdown: [
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
                      ],
                    ),
                    buildPdfPicker(),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      text: 'Unggah Surat',
                      onPressed: () {
                        AppHelper.showCustomAlertDialog(
                            title: 'Unggah Permohonan',
                            context: context,
                            content:
                            'Are you sure you want to upload this document?',
                            onNegativePressed: () {
                              Navigator.pop(context);
                            },
                            negativeButtonText: 'Cancel',
                            onPositivePressed: () {
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
      'Permohonan Surat Izin',
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
