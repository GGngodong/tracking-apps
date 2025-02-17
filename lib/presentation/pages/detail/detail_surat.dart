import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/detail/get_detail_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/edit/edit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/get_permit_bloc.dart';
import 'package:tracking_apps/presentation/component/card_detail.dart';
import 'package:tracking_apps/presentation/component/skeleton_card.dart';
import 'package:tracking_apps/presentation/pages/detail/detailDokumen/detail_pdf.dart';
import 'package:tracking_apps/presentation/pages/edit/edit_page.dart';

class DetailSuratPage extends StatefulWidget {
  final String id;
  final String role;

  const DetailSuratPage({super.key, required this.id, required this.role});

  @override
  State<DetailSuratPage> createState() => _DetailSuratPageState();
}

class _DetailSuratPageState extends State<DetailSuratPage> {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid ID or missing authentication token.')),
      );
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
          if (state is PermitLetterFailedState) {
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

  Widget _loadingBody() {
    print('================== IN DETAIL PERMIT LOADING ==================');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SkeletonCard(),
    );
  }

  Widget _loadedBody(DetailPermitLetterLoadedState state) {
    final editBloc = BlocProvider.of<EditBloc>(context);
    print('Permit Details in UI: ${state.permit!.toJson()}');
    print('================== IN DETAIL PERMIT LOADED ==================');
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            CardDetailSurat(
              processStatus: state.permit!.processStatus,
              uploadStatus: state.permit!.uploadStatus ?? 'Pending',
              id: state.permit!.id,
              date: state.permit!.date,
              categorySurat: state.permit!.categoryPermit,
              namaDokumen: state.permit!.description,
              namaPerusahaan: state.permit!.companyName,
              noSurat: state.permit!.noPermit,
              noSuratIzinMabes: state.permit!.noPermitMabes ?? 'Belum Terbit',
              note: state.permit!.note ?? 'Tidak ada catatan',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailPDFPage(
                          documentUrl: state.permit.documentUrl,
                        ),
                      ),
                    ),
                    child: Text(
                      'Lihat Dokumen',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  widget.role == 'ADMIN'
                      ? Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE02020),
                            ),
                            onPressed: () {
                              AppHelper.alertDialogMessage(context: context, content: 'Are you sure you want to delete this document?', onPressed: () async {
                                editBloc.add(DeleteDataButtonPressed(id: widget.id));
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              'Delete Permit',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Satoshi',
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
                                      id: state.permit!.id.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Edit Field',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Satoshi',
                                    color: Colors.white),
                              ),
                            ),
                        ],
                      )
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _failedBody(DetailPermitLetterFailedState state) {
    print('================== IN DETAIL PERMIT FAILED ==================');
    print('${state.message}');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          Image.asset(
            'assets/icons/cards_empty.png',
            height: 120.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              'Failed to fetch data',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Center(
            child: Text(
              state.message ?? 'Unknown error occurred',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: _fetchPermitLetters,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
