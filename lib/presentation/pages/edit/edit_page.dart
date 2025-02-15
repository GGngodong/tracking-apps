import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/detail/get_detail_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/edit/edit_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/dropdown_form_status_tahapan.dart';

part 'edit_mixin.dart';

class EditPage extends StatefulWidget {
  final String id;
  const EditPage({super.key, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> with EditMixin {
  @override
  Widget build(BuildContext context) {
    final EditBloc _editBloc = BlocProvider.of<EditBloc>(context);
    return BlocListener<EditBloc, EditState>(
      listener: (context, state) {
        _listener(state);
      },
      child: BlocBuilder<EditBloc, EditState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.whitePage,
            appBar: _appBar(),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Surat Izin',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  DropdownFormStatusTahapan(
                    header: 'Status Tahapan',
                    onCategoryChanged: (value) {
                      _submit(_editBloc);

                    },
                    textEditingController: _statusProcessTextEditingController,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  DropdownFormStatusTahapan(
                    header: 'Produk Mabes',
                    onCategoryChanged: (value) {
                      _submit(_editBloc);

                    },
                    textEditingController: _noPermitMabesTextEditingController,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                  CustomButton(
                    text: 'Edit Dokumen',
                    onPressed: () {
                      _submit(_editBloc);
                    },
                    isLogOut: false,
                    isLoading: state.isLoading,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Edit',
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
