import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/get_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/card_expanded.dart';
import 'package:tracking_apps/presentation/component/custom_search_bar.dart';
import 'package:tracking_apps/presentation/component/skeleton_list.dart';
import 'package:tracking_apps/presentation/pages/detail/detail_surat.dart';

class ListSuratPage extends StatefulWidget {
  const ListSuratPage({super.key});

  @override
  State<ListSuratPage> createState() => _ListSuratPageState();
}

class _ListSuratPageState extends State<ListSuratPage> {
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
      backgroundColor: AppColors.whitePage,
      appBar: _appBar(),
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
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PermitLetterBloc>().add(GetPermitLetter());
              },
              child: _buildBody(state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(PermitLetterState state) {
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

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'List Surat',
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

  Widget _loadingBody() {
    print('================== IN PERMIT LOADING ==================');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: ListView.separated(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SkeletonList();
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 8.h,
          );
        },
        itemCount: 5,
      ),
    );
  }

  Widget _loadedBody(PermitLetterLoadedState state) {
    print('================== IN PERMIT LOADED ==================');
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          CustomSearchBar(
            hintText: 'Cari Surat Izin',
            searchType: TypeSearchBar.withDropdownFilter,
            items: const ['OPS', 'DTM', 'DTU', 'DKK'],
          ),
          SizedBox(height: 20.h),
          state.listPermitLetter.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: 50.h),
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
                )
              : ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final permit = state.listPermitLetter[index];
                    return CardExpanded(
                      date: permit.date,
                      categorySurat: permit.categoryPermit,
                      namaDokumen: permit.description,
                      namaPerusahaan: permit.companyName,
                      noSurat: permit.noPermit,
                      noSuratIzinMabes: permit.noPermitMabes ?? 'Belum Terbit',
                      processStatus: permit.processStatus,
                      fun: () {
                        final profileState = context.read<ProfileBloc>().state;
                        final role = profileState.user!.role;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => DetailSuratPage(
                              id: permit.id.toString(),
                              role: role,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemCount: state.listPermitLetter.length,
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
