import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/get_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/search/search_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/card_surat.dart';
import 'package:tracking_apps/presentation/component/custom_search_bar.dart';
import 'package:tracking_apps/presentation/pages/detail/detail_surat.dart';
import 'package:tracking_apps/presentation/test_main_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _authToken;

  final List<String> _textSearchFields = ['uraian', 'no_surat', 'nama_pt'];
  String _selectedTextField = 'uraian';

  final List<String> _categoryOptions = ['OPS', 'DTU', 'DTM', 'DKK'];
  String _selectedCategory = '';

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
    }
  }

  void _fetchPermitLetters() {
    if (_authToken != null) {
      context.read<PermitLetterBloc>().add(GetPermitLetter());
    }
  }

  Future<void> _doSearch() async {
    if (_searchController.text.isNotEmpty) {
      context.read<SearchBloc>().add(
            SearchPermitLetter(
              _searchController.text,
              _selectedTextField,
              // Pass category filter if selected; otherwise empty.
              categoryPermitSearchQuery: _selectedCategory,
              categoryPermitSearchParam:
                  _selectedCategory.isNotEmpty ? "kategori_permit_letter" : "",
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whitePage,
      appBar: _appBar(),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchEmptyState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Fetching failed: ${state.message}')),
            );
          }
        },
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          // First chip row for text search fields.
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _textSearchFields.map((field) {
                String display = (field == 'no_surat')
                    ? 'No. Surat'
                    : (field == 'nama_pt')
                        ? 'Nama PT'
                        : 'Uraian';
                bool isSelected = field == _selectedTextField;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    label: Text(
                      display,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Color(0xff489FB5),
                    onSelected: (selected) {
                      setState(() {
                        _selectedTextField = field;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10.h),
          // Second chip row for category options.
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categoryOptions.map((category) {
                bool isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Color(0xff489FB5),
                    onSelected: (selected) {
                      setState(() {
                        if (isSelected) {
                          _selectedCategory = '';
                        } else {
                          _selectedCategory = category;
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20.h),
          CustomSearchBar(
            controller: _searchController,
            hintText: 'Cari Surat Izin',
            searchType: TypeSearchBar.regular,
            items: const [],
            isSubmitted: (query) {
              if (query.isNotEmpty) {
                _doSearch();
              }
            },
            onChanged: (value) {},
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _doSearch,
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoadedState) {
                    List<PermitModel> permits = state.listPermitLetter;
                    if (permits.isEmpty) {
                      return const Center(child: Text('No permits found.'));
                    }
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: permits.length,
                      itemBuilder: (context, index) {
                        final permit = permits[index];
                        return CardSurat(
                            processStatus: permit.processStatus,
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
                                    id: permit.id.toString(),
                                    role: role,
                                  ),
                                ),
                              );
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
                            });
                      },
                    );
                  } else if (state is SearchEmptyState) {
                    return Center(
                      child: SizedBox(
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
                      ),
                    );
                  }
                  else if (state is SearchFailedState) {
                    return Center(
                      child: Text(
                        state.message ?? 'An error occurred.',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(child: Text('Mulai mencari ...'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Cari Surat Izin',
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
}