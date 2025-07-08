import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/notification/all/notification_bloc.dart';
import 'package:tracking_apps/presentation/blocs/notification/edit/notification_edit_bloc.dart';
import 'package:tracking_apps/presentation/component/card_notification.dart';
import 'package:tracking_apps/presentation/component/notification_empty.dart';
import 'package:tracking_apps/presentation/component/user_unauthorized.dart';

import 'detail/detail_notification_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      _fetchNotifications();
    } else {
      UserUnauthorized();
    }
  }

  Future<void> _fetchNotifications() async {
    if (_authToken != null) {
      context
          .read<NotificationBloc>()
          .add(LoadNotifications(authToken: _authToken!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePage,
      appBar: _appBar(),
      body: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: _fetchNotifications,
          child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: AppColors.primary,
          ));
        } else if (state is NotificationLoadFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is NotificationLoadSuccess) {
          final notifications = state.notificationListResponse.notifications;
          if (notifications.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 190.h),
              child: NotificationEmpty(),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return CardNotification(
                  date: notification.createdAt,
                  notification: notification.data.message,
                  uploadStatus: notification.data.uploadStatus ?? '',
                  type: notification.data.type,
                  isRead: notification.readAt != null,
                  onTap: () {
                    final editBloc = context.read<NotificationEditBloc>();
                    editBloc.add(
                      MarkNotificationAsReadEvent(
                        authToken: _authToken!,
                        notificationId: notification.id,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNotificationPage(
                            notificationId: notification.id),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Notifikasi',
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
