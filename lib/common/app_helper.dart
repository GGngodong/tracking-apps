import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_apps/common/constant.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';

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
    void Function()? onPressed,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: TextStyle(
                    color: CupertinoColors.systemRed,
                  ),
                )
              : null,
          content: content != null
              ? Text(
                  content,
                  textAlign: TextAlign.start,
                )
              : null,
          actions: [
            CupertinoDialogAction(
              onPressed: onPressed ?? () => context.pop(),
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }
}
