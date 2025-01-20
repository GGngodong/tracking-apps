import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/get_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/card_surat.dart';
import 'package:tracking_apps/presentation/component/header.dart';
import 'package:tracking_apps/presentation/component/skeleton_card.dart';
import 'package:tracking_apps/presentation/pages/detail/detail_surat.dart';
import 'package:tracking_apps/presentation/pages/listSurat/list_surat.dart';

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
    }
  }

  void _fetchPermitLetters() {
    if (_authToken != null) {
      context.read<PermitLetterBloc>().add(GetPermitLetter());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.whitePage,
        body: BlocListener<PermitLetterBloc, PermitLetterState>(
          listener: (context, state) {
            if (state is PermitLetterFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Fetching failed: ${state.message}')),
              );
            }
          },
          child: BlocBuilder<PermitLetterBloc, PermitLetterState>(
              builder: (context, state) {
            if (state is PermitLetterLoadingState || state.isLoading) {
              return _loadingBody();
            } else if (state is PermitLetterLoadedState) {
              return _loadedBody(state);
            } else if (state is PermitLetterFailedState) {
              return _failedBody(state);
            } else {
              return _loadingBody();
            }
          }),
        ));
  }

  Widget _loadingBody() {
    print('================== IN PERMIT LOADING ==================');
    return Column(
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
              child: SkeletonCard(),
            ),
          ],
        ),
      ],
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
                child: ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final permit = state.listPermitLetter[index];
                    return CardSurat(
                        date: permit.date,
                        categorySurat: permit.categoryPermit,
                        namaDokumen: permit.description,
                        namaPerusahaan: permit.companyName,
                        noSurat: permit.noPermit,
                        noSuratIzinMabes:
                            permit.noPermitMabes ?? 'Belum Terbit',
                        funcDownload: () {},
                        funcRead: () {
                          final profileState =
                              context.read<ProfileBloc>().state;
                          final role = profileState.user!.role;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DetailSuratPage(
                                role: role,
                                id: permit.id.toString(),
                              ),
                            ),
                          );
                        },
                        detailSurat: () {
                          BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, profileState) {
                              return DetailSuratPage(
                                role: profileState.user!.role,
                                id: permit.id.toString(),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const ListSuratPage(),
                ),
              ),
              child: Text(
                'Lihat Selengkapnya',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
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
          Text(
            'Failed to fetch data',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10.h),
          Text(
            state.message ?? 'Unknown error occurred',
            style: TextStyle(fontSize: 14.sp, color: Colors.red),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: _fetchPermitLetters,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
