import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/helper/download_helper.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/latest/get_latest_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/card_surat.dart';
import 'package:tracking_apps/presentation/component/header.dart';
import 'package:tracking_apps/presentation/component/skeleton_card.dart';
import 'package:tracking_apps/presentation/component/user_unauthorized.dart';
import 'package:tracking_apps/presentation/pages/detail/permit_detail.dart';
import 'package:tracking_apps/presentation/pages/list/permit/selengkapnya.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _authToken;

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
    _fetchPermitLetters();
  }

  Future<void> _loadAuthToken() async {
    final token = await SharedPreferencesService.instance
        .getData<String>(PreferenceKey.authToken);
    setState(() {
      _authToken = token;
    });
    if (token != null) {
      _fetchPermitLetters();
    } else {
      UserUnauthorized();
    }
  }

  void _fetchPermitLetters() {
    if (_authToken != null) {
      context.read<PermitLetterLatestBloc>().add(GetListPermitLetter());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whitePage,
      body: BlocListener<PermitLetterLatestBloc, PermitLetterLatestState>(
        listener: (context, state) {
          if (state is PermitLetterFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Fetching failed: ${state.message}')),
            );
          }
        },
        child: BlocBuilder<PermitLetterLatestBloc, PermitLetterLatestState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context
                    .read<PermitLetterLatestBloc>()
                    .add(GetListPermitLetter());
              },
              child: _buildBody(state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(PermitLetterLatestState state) {
    if (state is PermitLetterLoadingState || state.isLoading) {
      return _loadingBody();
    } else if (state is PermitLetterLoadedState) {
      return _loadedBody(state);
    } else if (state is PermitLetterFailedState) {
      return _failedBody(state);
    } else {
      return _loadingBody();
    }
  }

  Widget _loadingBody() {
    print('================== IN PERMIT LOADING ==================');
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              Header(
                heightSizedBox: 280.h,
                imageBg: 'assets/home/dahana-gedung.png',
                // imageFg: 'assets/home/dahana.png',
                imageFg: '',
                height: 100.h,
                topFg: 90,
                leftFg: 0,
                rightFg: 0,
                topBg: 40,
                leftBg: 0,
                rightBg: 0,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        minWidth: 0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: Text(
                  'Surat Izin Terbaru',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: SkeletonCard(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SelengkapnyaPage(),
                      ),
                    ),
                    child: Text(
                      'Lihat Selengkapnya',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _loadedBody(PermitLetterLoadedState state) {
    print('================== IN PERMIT LOADED ==================');
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              Header(
                heightSizedBox: 280.h,
                imageBg: 'assets/home/dahana-gedung.png',
                imageFg: 'assets/home/dahana.png',
                height: 100.h,
                topFg: 90,
                leftFg: 0,
                rightFg: 0,
                topBg: 40,
                leftBg: 0,
                rightBg: 0,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        minWidth: 0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: Text(
                  'Surat Izin Terbaru',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: state.listPermitLetter.isEmpty
                    ? RefreshIndicator(
                        color: AppColors.primary,
                        onRefresh: () async {
                          context
                              .read<PermitLetterLatestBloc>()
                              .add(GetListPermitLetter());
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/document_empty.png',
                              height: 120.h,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: Text(
                                'Tidak ada surat izin',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Silahkan cek kembali nanti',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final permit = state.listPermitLetter[index];
                          return CardSurat(
                              processStatus: permit.processStatus,
                              date: permit.date,
                              categorySurat: permit.categoryPermit,
                              namaDokumen: permit.description,
                              namaPerusahaan: permit.companyName,
                              noSurat: permit.noPermit,
                              noSuratIzinMabes:
                                  permit.noPermitMabes ?? 'Belum Terbit',
                              uploadStatus: permit.uploadStatus ?? 'PENDING',
                              funcDownloadSuratTerbit: () async {
                                final url = permit.releasedDocumentUrl;

                                if (url == null ||
                                    url.isEmpty ||
                                    url == 'No Released Document Url') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Permit is not released yet.")),
                                  );
                                  return;
                                }

                                final taskId =
                                    await DownloadHelper.downloadFile(
                                  url: url,
                                  savedFileName: 'permit_${permit.id}.pdf',
                                  context: context,
                                );

                                if (taskId != null) {
                                  debugPrint(
                                      'Download task enqueued (Surat Terbit): $taskId');
                                }
                              },
                              funcDownloadPermohonan: () async {
                                final url = permit.documentUrl;

                                if (url == null || url.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("No document URL available.")),
                                  );
                                  return;
                                }

                                final taskId =
                                    await DownloadHelper.downloadFile(
                                  url: url,
                                  savedFileName: 'permit_${permit.id}.pdf',
                                  context: context,
                                );

                                if (taskId != null) {
                                  debugPrint(
                                      'Download task enqueued (Permohonan): $taskId');
                                }
                              },
                              funcRead: () {
                                final profileState =
                                    context.read<ProfileBloc>().state;
                                final role = profileState.user!.role;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DetailPermitPage(
                                      id: permit.id.toString(),
                                      role: role,
                                    ),
                                  ),
                                );
                              },
                              detailSurat: () {
                                BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, profileState) {
                                    return DetailPermitPage(
                                      id: permit.id.toString(),
                                      role: profileState.user!.role,
                                    );
                                  },
                                );
                              });
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: state.listPermitLetter.length,
                      ),
              ),
            ],
          ),
          state.listPermitLetter.isEmpty
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SelengkapnyaPage(),
                      ),
                    ),
                    child: Text(
                      'Lihat Selengkapnya',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  Widget _failedBody(PermitLetterFailedState state) {
    print('================== IN PERMIT FAILED ==================');
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
                fontFamily: 'Satoshi',
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
                fontFamily: 'Satoshi',
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
