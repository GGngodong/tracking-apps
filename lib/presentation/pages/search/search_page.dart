import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';
import 'package:tracking_apps/helper/download_helper.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/get_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/search/search_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/card_surat.dart';
import 'package:tracking_apps/presentation/component/custom_bottom_sheet_filter.dart';
import 'package:tracking_apps/presentation/component/custom_search_bar.dart';
import 'package:tracking_apps/presentation/component/user_unauthorized.dart';
import 'package:tracking_apps/presentation/pages/detail/permit_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _authToken;

  final String _defaultSearchField = 'uraian';

  String _selectedCategory = '';
  String _selectedSubCategory = '';

  final TextEditingController _searchController = TextEditingController();

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
      context.read<PermitLetterBloc>().add(GetListPermitLetter());
    }
  }

  Future<void> _doSearch() async {
    if (_searchController.text.isNotEmpty) {
      context.read<SearchBloc>().add(
            SearchPermitLetter(
              _searchController.text,
              _defaultSearchField,
              categoryPermitSearchQuery: _selectedCategory,
              categoryPermitSearchParam:
                  _selectedCategory.isNotEmpty ? "kategori_permit_letter" : "",
              subCategoryPermitSearchQuery: _selectedSubCategory,
              subCategoryPermitSearchParam: _selectedSubCategory.isNotEmpty
                  ? "sub_kategori_permit_letter"
                  : "",
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whitePage,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 70.h,
        backgroundColor: AppColors.whitePage,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: CustomSearchBar(
                  controller: _searchController,
                  hintText: 'Cari Surat Permohonan',
                  searchType: TypeSearchBar.regular,
                  items: const [],
                  isSubmitted: (query) {
                    if (query.isNotEmpty) {
                      _doSearch();
                    }
                  },
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  onPressed: () async {
                    // Show the bottom sheet filter
                    final result =
                        await showModalBottomSheet<Map<String, String>>(
                      context: context,
                      enableDrag: true,
                      scrollControlDisabledMaxHeightRatio: 0.85,
                      backgroundColor: Colors.transparent,
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.r)),
                      ),
                      builder: (context) => CustomBottomSheetFilter(
                        initialCategory: _selectedCategory,
                        initialSubCategory: _selectedSubCategory,
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        _selectedCategory = result['category'] ?? '';
                        _selectedSubCategory = result['subCategory'] ?? '';
                      });
                      _doSearch();
                    }
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    size: 24.sp,
                    color: const Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchEmptyState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Fetching failed: ${state.message}')),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: _doSearch,
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ));
                      } else if (state is SearchLoadedState) {
                        List<PermitModel> permits = state.listPermitLetter;
                        if (permits.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/search_empty.png',
                                  height: 120.h,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Data tidak ditemukan',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 20.h),
                          itemCount: permits.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final permit = permits[index];
                            return CardSurat(
                              uploadedBy: permit.uploadedBy,
                              processStatus: permit.processStatus,
                              date: permit.date,
                              uploadStatus: permit.uploadStatus ?? 'Pending',
                              categorySurat: permit.categoryPermit,
                              namaDokumen: permit.description,
                              namaPerusahaan: permit.companyName,
                              noSurat: permit.noPermit,
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
                              noSuratIzinMabes:
                                  permit.noPermitMabes ?? 'Belum Terbit',
                              funcRead: () {
                                final profileState =
                                    context.read<ProfileBloc>().state;
                                final role = profileState.user!.role;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPermitPage(
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
                              },
                            );
                          },
                        );
                      } else if (state is SearchEmptyState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/search_empty.png',
                                height: 120.h,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                'Data tidak ditemukan',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Satoshi',
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is SearchFailedState) {
                        return Center(
                          child: Text(
                            state.message ?? 'An error occurred.',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'Mulai mencari ...',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
