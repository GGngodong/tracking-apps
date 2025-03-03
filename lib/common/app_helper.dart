import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/constant.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class AppHelper {
  static HttpResponseModel checkEmailAndPassword(
      {required String email, required String password}) {
    if (!Constant.emailRegex.hasMatch(email)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Email Address');
    }
    if (!Constant.passwordRegex.hasMatch(password)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Password');
    }
    return HttpResponseModel(statusCode: 200);
  }

  static HttpResponseModel checkUsernameEmailAndPassword(
      {required String username,
      required String email,
      required String password}) {
    if (!Constant.usernameRegex.hasMatch(username)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Username');
    }
    if (!Constant.emailRegex.hasMatch(email)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Email Address');
    }
    if (!Constant.passwordRegex.hasMatch(password)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Password');
    }
    return HttpResponseModel(statusCode: 200);
  }

  static HttpResponseModel checkUsername({required String username}) {
    if (!Constant.usernameRegex.hasMatch(username)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Username');
    }
    return HttpResponseModel(statusCode: 200);
  }

  static HttpResponseModel checkEmail({required String email}) {
    if (!Constant.emailRegex.hasMatch(email)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Email');
    }
    return HttpResponseModel(statusCode: 200);
  }

  static HttpResponseModel checkPassword({required String password}) {
    if (!Constant.passwordRegex.hasMatch(password)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Password');
    }
    return HttpResponseModel(statusCode: 200);
  }

  static HttpResponseModel checkUploadedData(
      {required String description,
      required String noPermit,
      required companyName}) {
    if (!Constant.descriptionRegex.hasMatch(description)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Description');
    }
    if (!Constant.noPermitRegex.hasMatch(noPermit)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Nomor Permit');
    }
    if (!Constant.companyNameRegex.hasMatch(companyName)) {
      return HttpResponseModel(
          statusCode: 401, message: 'Enter The Valid Nama PT');
    } else {
      return HttpResponseModel(statusCode: 200);
    }
  }

  static void alertDialogMessage({
    required BuildContext context,
    String? title,
    String? content,
    Widget? image,
    void Function()? onPressedYes,
    onPressedNo,
    bool barrierDismissible = true,
    bool isLogOut = false,
    bool isFailed = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: title != null
              ? Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                )
              : null,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null)
                Center(
                  child: image,
                ),
              if (content != null)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0.h),
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            if (isLogOut)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed:
                        onPressedYes ?? () => Navigator.of(context).pop(),
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(color: AppColors.primary),
                      ),
                    ),
                    onPressed: onPressedNo ?? () => Navigator.of(context).pop(),
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ),
                ],
              ),
            if (isFailed)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: onPressedYes ?? () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
