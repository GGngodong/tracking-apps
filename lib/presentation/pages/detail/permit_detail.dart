import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/detail/get_detail_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/edit/edit_bloc.dart';
import 'package:tracking_apps/presentation/component/document_empty_page.dart';
import 'package:tracking_apps/presentation/component/user_unauthorized.dart';
import 'package:tracking_apps/presentation/pages/detail/detailDokumen/detail_pdf.dart';
import 'package:tracking_apps/presentation/pages/edit/edit_page.dart';

class DetailPermitPage extends StatefulWidget {
  final String id;
  final String role;

  const DetailPermitPage({super.key, required this.id, required this.role});

  @override
  State<DetailPermitPage> createState() => _DetailPermitPageState();
}

class _DetailPermitPageState extends State<DetailPermitPage> {
  String? _authToken;

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

    if (token != null) {
      _fetchPermitLetters();
    }
  }

  void _fetchPermitLetters() {
    if (_authToken != null) {
      context.read<DetailPermitLetterBloc>().add(
            GetDetailPermitLetterEvent(id: widget.id),
          );
    } else {
      UserUnauthorized();
    }
  }

  Future<void> _refresh() async {
    _fetchPermitLetters();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Surat',
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
      ),
      body: BlocListener<DetailPermitLetterBloc, DetailPermitLetterState>(
        listener: (context, state) {
          if (state is DetailPermitLetterFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Fetching failed: ${state.message}')),
            );
          } else if (state is DetailPermitLetterLoadedState) {
            print('Loaded State: ${state.permit}');
          }
        },
        child: BlocBuilder<DetailPermitLetterBloc, DetailPermitLetterState>(
          builder: (context, state) {
            if (state is DetailPermitLetterLoadingState || state.isLoading) {
              return _loadingBody();
            } else if (state is DetailPermitLetterLoadedState) {
              return _loadedBody(state);
            } else if (state is DetailPermitLetterFailedState) {
              return _failedBody(state);
            } else {
              return _loadingBody();
            }
          },
        ),
      ),
    );
  }

  Widget _failedBody(DetailPermitLetterFailedState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          Image.asset(
            'assets/icons/cards_empty.png',
            height: 120.h,
          ),
          SizedBox(height: 10.h),
          Text(
            'Failed to fetch data',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            state.message ?? 'Unknown error occurred',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: _fetchPermitLetters,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _loadingBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _loadedBody(DetailPermitLetterLoadedState state) {
    final editBloc = BlocProvider.of<EditBloc>(context);
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            _buildRow('Nama Surat', state.permit.description),
            SizedBox(height: 10.h),
            _buildRow('No. Surat', state.permit.noPermit),
            SizedBox(height: 10.h),
            _buildRow('Kategori', state.permit.categoryPermit),
            SizedBox(height: 10.h),
            _buildRow('Nama Perusahaan', state.permit.companyName),
            SizedBox(height: 10.h),
            _buildRow('Tanggal Masuk Berkas', state.permit.date),
            SizedBox(height: 10.h),
            _buildRow('No. Surat Izin Mabes',
                state.permit.noPermitMabes ?? 'Belum Terbit'),
            SizedBox(height: 10.h),
            _buildRow('Status Tahapan', state.permit.uploadStatus ?? 'Pending'),
            SizedBox(height: 10.h),
            _buildRow('Proses Status', state.permit.processStatus),
            SizedBox(height: 10.h),
            _buildRow('Status', state.permit.note ?? 'Tidak ada catatan.'),
            SizedBox(height: 20.h),
            _buildRowWithWidget(
              'Dokumen Permohonan',
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lihat',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Satoshi',
                      color: AppColors.lightGrey,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                    color: AppColors.primary,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailPDFPage(documentUrl: state.permit.documentUrl),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            _buildRowWithWidget(
              'Dokumen Terbit',
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lihat',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Satoshi',
                      color: AppColors.lightGrey,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                    color: AppColors.primary,
                  ),
                ],
              ),
              onTap: () {
                final url = state.permit.releasedDocumentUrl;
                if (url == null ||
                    url.isEmpty ||
                    url == 'No Released Document Url') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DocumentEmptyPage(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPDFPage(documentUrl: url),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20.h),
            widget.role == 'ADMIN'
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE02020),
                          ),
                          onPressed: () {
                            AppHelper.showCustomAlertDialog(
                                title: 'Delete Permit',
                                context: context,
                                content:
                                    'Are you sure you want to delete this document?',
                                onNegativePressed: () =>
                                    Navigator.of(context).pop(),
                                negativeButtonText: 'Cancel',
                                onPositivePressed: () async {
                                  editBloc.add(
                                    DeleteDataButtonPressed(
                                      id: widget.id,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                  Future.delayed(Duration(milliseconds: 300));
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                });
                          },
                          child: Text(
                            'Delete Permit',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF39B43B),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(
                                  id: state.permit.id.toString(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Satoshi',
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildRowWithWidget(
    String title,
    Widget rightSideWidget, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '$title :',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Satoshi',
                  color: AppColors.primary,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: rightSideWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title :',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Satoshi',
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Satoshi',
                color: AppColors.lightGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
