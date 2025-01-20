import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/detail/get_detail_permit.bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/get_permit_bloc.dart';
import 'package:tracking_apps/presentation/component/card_detail.dart';
import 'package:tracking_apps/presentation/component/skeleton_card.dart';
import 'package:tracking_apps/presentation/pages/detail/detailDokumen/detail_pdf.dart';

class DetailSuratPage extends StatefulWidget {
  final String role;
  final String id;

  const DetailSuratPage({super.key, required this.role, required this.id});

  @override
  State<DetailSuratPage> createState() => _DetailSuratPageState();
}

class _DetailSuratPageState extends State<DetailSuratPage> {
  bool isEditing = false;
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

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.role == 'ADMIN' && isEditing
              ? 'Edit Detail Surat'
              : 'Detail Surat',
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
    print('Permit Details in UI: ${state.permit!.toJson()}');
    print('================== IN DETAIL PERMIT LOADED ==================');
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Detail Surat',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CardDetailSurat(
            date: state.permit!.date,
            categorySurat: state.permit!.categoryPermit,
            namaDokumen: state.permit!.description,
            namaPerusahaan: state.permit!.companyName,
            noSurat: state.permit!.noPermit,
            noSuratIzinMabes: state.permit!.noPermitMabes ?? 'Belum Terbit',
            isEditing: isEditing,
            onFieldChanged: (field, value) {
              if (field == 'tanggal') state.permit!.date = value;
              if (field == 'kategori_permit_letter') state.permit!.categoryPermit = value;
              if (field == 'no_surat') state.permit!.noPermit = value;
              if (field == 'nama_pt') state.permit!.companyName = value;
              if (field == 'uraian') state.permit!.description = value;
              if (field == 'produk_no_surat_mabes') state.permit!.noPermitMabes = value;
            },
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
                      builder: (BuildContext context) => DetailPDFPage(documentUrl: state.permit.documentUrl,
                      ),
                    ),
                  ),
                  child: Text(
                    'Lihat Dokumen',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                if (widget.role == 'ADMIN')
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isEditing ? Color(0xFF39B43B) : Color(0xFFAF4848),
                    ),
                    onPressed: _toggleEdit,
                    child: Text(
                      isEditing ? 'Save' : 'Edit Field',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          )
        ],
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
