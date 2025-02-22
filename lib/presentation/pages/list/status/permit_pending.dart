
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/pending/get_pending_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/card_surat.dart';
import 'package:tracking_apps/presentation/component/document_empty.dart';
import 'package:tracking_apps/presentation/component/skeleton_card.dart';
import 'package:tracking_apps/presentation/pages/detail/detail_surat.dart';

class PermitPending extends StatefulWidget {
  const PermitPending({super.key});

  @override
  State<PermitPending> createState() => _PermitPendingState();
}

class _PermitPendingState extends State<PermitPending> {
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
      context.read<PermitLetterPendingBloc>().add(GetListPermitLetter());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermitLetterPendingBloc, PermitLetterPendingState>(
      listener: (context, state) {
        if (state is PermitLetterFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fetching failed: ${state.message}')),
          );
        }
      },
      child: BlocBuilder<PermitLetterPendingBloc, PermitLetterPendingState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<PermitLetterPendingBloc>()
                  .add(GetListPermitLetter());
            },
            child: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(PermitLetterPendingState state) {
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
    if(state.listPermitLetter.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 190.h),
        child: DocumentEmpty(),
      );
    } else {
      return SingleChildScrollView(
        child : ListView.separated(
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
              funcRead: () {
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
              funcDownload: () async {
                final url = permit.documentUrl;
                final externalDir = await getExternalStorageDirectory();
                if (externalDir != null) {
                  try {
                    final taskId = await FlutterDownloader.enqueue(
                      url: url,
                      savedDir: externalDir.path,
                      fileName:
                      'Surat Permohonan ${permit.description}.pdf',
                      showNotification: true,
                      openFileFromNotification: true,
                    );
                    debugPrint(
                        'Download task enqueued with taskId: $taskId');
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Download failed: $e")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("Unable to access storage directory")),
                  );
                }
              },
              detailSurat: () {
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profileState) {
                    return DetailSuratPage(
                      id: permit.id.toString(),
                      role: profileState.user!.role,
                    );
                  },
                );
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
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
    return ListView(
      children: [
        SkeletonCard(),
        SizedBox(height: 20.h),
        SkeletonCard(),
        SizedBox(height: 20.h),
      ],
    );
  }
}
