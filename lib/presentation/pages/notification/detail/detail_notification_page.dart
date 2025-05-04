import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/domain/entity/notification_model.dart';
import 'package:tracking_apps/presentation/blocs/notification/all/notification_bloc.dart';
import 'package:tracking_apps/presentation/blocs/notification/detail/notification_detail_bloc.dart';
import 'package:tracking_apps/presentation/blocs/notification/edit/notification_edit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/pages/detail/detail_surat.dart';

class DetailNotificationPage extends StatefulWidget {
  final String notificationId;

  const DetailNotificationPage({
    super.key,
    required this.notificationId,
  });

  @override
  State<DetailNotificationPage> createState() => _DetailNotificationPageState();
}

class _DetailNotificationPageState extends State<DetailNotificationPage> {
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
      _fetchDetailNotification();
    }
  }

  Future<void> _fetchDetailNotification() async {
    if (_authToken != null) {
      context.read<NotificationDetailBloc>().add(
            LoadNotificationDetail(
              authToken: _authToken!,
              notificationId: widget.notificationId,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.notificationId);
    return Scaffold(
      backgroundColor: AppColors.whitePage,
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NotificationDetailBloc, NotificationDetailState>(
        builder: (context, state) {
      if (state is NotificationLoading) {
        return Center(
            child: CircularProgressIndicator(
          color: AppColors.primary,
        ));
      } else if (state is NotificationDetailSuccess) {
        final NotificationModel detail = state.notificationDetail;
        if (detail.data.type == 'user_permit_letter') {
          if (detail.data.uploadStatus?.isNotEmpty ?? false) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat("MM-dd-yyyy • HH:mm")
                          .format(detail.createdAt.toLocal()),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Your permit letter status is ${detail.data.uploadStatus}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      detail.data.message,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Lihat Detail Surat',
                  onPressed: () {
                    final profileState = context.read<ProfileBloc>().state;
                    final role = profileState.user!.role;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailSuratPage(
                          id: state.notificationDetail.data.permitLetterId,
                          role: role,
                        ),
                      ),
                    );
                  },
                  isLogOut: false,
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("MM-dd-yyyy • HH:mm")
                      .format(detail.createdAt.toLocal()),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Successfully Uploaded Permit Letter',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  detail.data.message,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          }
        } else if (detail.data.type == 'admin_permit_letter') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("MM-dd-yyyy • HH:mm")
                        .format(detail.createdAt.toLocal()),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'New Permit Letter Has Been Uploaded',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    detail.data.message,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              CustomButton(
                text: 'Lihat Detail Surat',
                onPressed: () {
                  final profileState = context.read<ProfileBloc>().state;
                  final role = profileState.user!.role;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DetailSuratPage(
                        id: state.notificationDetail.data.permitLetterId,
                        role: role,
                      ),
                    ),
                  );
                },
                isLogOut: false,
              ),
            ],
          );
        } else {
          return Align();
        }
      } else if (state is NotificationDetailFailure) {
        return Center(child: Text('Error: ${state.error}'));
      } else {
        return Center(
            child: CircularProgressIndicator(
          color: AppColors.primary,
        ));
      }
    });
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Detail Notifikasi',
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
      actions: [
        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          onSelected: (value) {
            if (value == 'delete') {
              AppHelper.showCustomAlertDialog(
                context: context,
                title: 'Delete Notification',
                content: 'Are you sure want to delete this notification?',
                onPositivePressed: () {
                  context.read<NotificationEditBloc>().add(
                        DeleteNotificationEvent(
                          authToken: _authToken!,
                          notificationId: widget.notificationId,
                        ),
                      );
                  Navigator.of(context).pop();
                  Future.delayed(Duration(milliseconds: 300));
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                onNegativePressed: () => Navigator.of(context).pop(),
                negativeButtonText: 'Cancel',
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'delete',
              child: Text(
                'Delete Notification',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w600,
                    color: Colors.red[500]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
