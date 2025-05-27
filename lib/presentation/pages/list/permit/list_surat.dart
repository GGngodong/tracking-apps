import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/helper/download_helper.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/get_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/card_surat.dart';
import 'package:tracking_apps/presentation/component/document_empty.dart';
import 'package:tracking_apps/presentation/component/skeleton_card.dart';
import 'package:tracking_apps/presentation/pages/detail/permit_detail.dart';

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
      context.read<PermitLetterBloc>().add(GetListPermitLetter());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermitLetterBloc, PermitLetterState>(
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
            color: AppColors.primary,
            onRefresh: () async {
              context.read<PermitLetterBloc>().add(GetListPermitLetter());
            },
            child: _buildBody(state),
          );
        },
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

  Widget _loadedBody(PermitLetterLoadedState state) {
    if (state.listPermitLetter.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 190.h),
        child: DocumentEmpty(),
      );
    } else {
      return SingleChildScrollView(
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
          itemBuilder: (context, index) {
            final permit = state.listPermitLetter[index];
            return CardSurat(
              date: permit.date,
              categorySurat: permit.categoryPermit,
              namaDokumen: permit.description,
              namaPerusahaan: permit.companyName,
              noSurat: permit.noPermit,
              noSuratIzinMabes: permit.noPermitMabes ?? 'Belum Terbit',
              processStatus: permit.processStatus,
              uploadStatus: permit.uploadStatus ?? 'PENDING',
              funcDownloadSuratTerbit: () async {
                final url = permit.releasedDocumentUrl;

                if (url == null ||
                    url.isEmpty ||
                    url == 'No Released Document Url') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Permit is not released yet.")),
                  );
                  return;
                }

                final taskId = await DownloadHelper.downloadFile(
                  url: url,
                  savedFileName: 'permit_${permit.id}.pdf',
                  context: context,
                );

                if (taskId != null) {
                  debugPrint('Download task enqueued (Surat Terbit): $taskId');
                }
              },
              funcDownloadPermohonan: () async {
                final url = permit.documentUrl;

                if (url == null || url.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No document URL available.")),
                  );
                  return;
                }

                final taskId = await DownloadHelper.downloadFile(
                  url: url,
                  savedFileName: 'permit_${permit.id}.pdf',
                  context: context,
                );

                if (taskId != null) {
                  debugPrint('Download task enqueued (Permohonan): $taskId');
                }
              },
              funcRead: () {
                final profileState = context.read<ProfileBloc>().state;
                final role = profileState.user!.role;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailPermitPage(id: permit.id.toString(), role: role),
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
                });
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 10.h,
          ),
          itemCount: state.listPermitLetter.length,
        ),
      );
    }
  }

  Widget _failedBody(PermitLetterFailedState state) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      children: [
        Center(
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
                  fontFamily: 'Satoshi',
                ),
              ),
              Text(
                state.message ?? 'Unknown error occurred',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Satoshi',
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: _fetchPermitLetters,
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loadingBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: ListView(
        children: [
          SkeletonCard(),
          SizedBox(height: 10.h),
          SkeletonCard(),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
