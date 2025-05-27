import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardNotification extends StatefulWidget {
  final String notification;
  final String uploadStatus;
  final String type;
  final DateTime date;
  final bool isRead;
  final VoidCallback onTap;

  const CardNotification({
    super.key,
    required this.notification,
    required this.uploadStatus,
    required this.type,
    required this.isRead,
    required this.onTap,
    required this.date,
  });

  @override
  State<CardNotification> createState() => _CardNotificationState();
}

class _CardNotificationState extends State<CardNotification> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIcon(),
            SizedBox(
              width: 10.w,
            ),
            Expanded(child: _buildText()),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    final textColor = widget.isRead ? Colors.grey : Colors.black;
    if (widget.type == 'user_permit_letter') {
      if (widget.uploadStatus?.isNotEmpty ?? false) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Permit Status - Permit Letter',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                Text(
                  DateFormat("MM-dd-yyyy '•' HH:mm")
                      .format(widget.date.toLocal()),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              'Your permit letter status is ${widget.uploadStatus}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              widget.notification,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload Status - Permit Letter',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                Text(
                  DateFormat("MM-dd-yyyy '•' HH:mm")
                      .format(widget.date.toLocal()),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              'Successfully Uploaded Permit Letter',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              widget.notification,
              maxLines: 2,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        );
      }
    } else if (widget.type == 'admin_permit_letter') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upload Status - Permit Letter',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              Text(
                DateFormat("MM-dd-yyyy '•' HH:mm")
                    .format(widget.date.toLocal()),
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'New Permit Letter Has Been Uploaded',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            widget.notification,
            maxLines: 2,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      );
    } else {
      return Align();
    }
  }

  Widget _buildIcon() {
    if (widget.type == 'user_permit_letter') {
      switch (widget.uploadStatus) {
        case 'PENDING':
          return Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF5F5F5), // Light Grey Background
            ),
            child: Icon(
              Icons.pending_actions,
              size: 20.sp,
              color: const Color(0xFFA9A9A9), // Pastel Grey Icon
            ),
          );
        case 'APPROVED':
          return Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4CAF50), // Green Background
            ),
            child: Icon(
              Icons.check_circle_outline_rounded,
              size: 20.sp,
              color: Colors.white, // White Icon
            ),
          );
        case 'REJECTED':
          return Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEB4034), // Red Background
            ),
            child: Icon(
              Icons.close_rounded,
              size: 20.sp,
              color: Colors.white, // White Icon
            ),
          );
        default:
          return Align();
      }
    } else if (widget.type == 'admin_permit_letter') {
      if (widget.uploadStatus == 'APPROVED') {
        return Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF4CAF50), // Green Background
          ),
          child: Icon(
            Icons.check_circle_outline_rounded,
            size: 20.sp,
            color: Colors.white, // White Icon
          ),
        );
      } else {
        return Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF5F5F5), // Light Grey Background
          ),
          child: Icon(
            Icons.cloud_upload_outlined,
            size: 20.sp,
            color: const Color(0xFFA9A9A9), // Pastel Grey Icon
          ),
        );
      }
    } else {
      return Align();
    }
  }
}
