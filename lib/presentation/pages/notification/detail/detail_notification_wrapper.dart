import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_apps/configs/network/notification/notification_service.dart';
import 'package:tracking_apps/presentation/blocs/notification/all/notification_bloc.dart';

import 'detail_notification_page.dart';

class DetailNotificationWrapper extends StatelessWidget {
  final String notificationId;

  const DetailNotificationWrapper({super.key, required this.notificationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(
        notificationService: context.read<NotificationService>(),
      ),
      child: DetailNotificationPage(notificationId: notificationId),
    );
  }
}
