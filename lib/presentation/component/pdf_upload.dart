import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class PdfUpload extends StatefulWidget {
  final String header;
  final Function onFileSelected;

  const PdfUpload(
      {super.key, required this.header, required this.onFileSelected});

  @override
  State<PdfUpload> createState() => _PdfUploadState();
}

class _PdfUploadState extends State<PdfUpload> {
  String? _fileName;
  bool _isFileSelected = false;

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _isFileSelected = true;
      });

      widget.onFileSelected(result.files.single.path);
    }
  }

  void _removeFile() {
    setState(() {
      _fileName = null;
      _isFileSelected = false;
    });

    widget.onFileSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.header,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: _pickPdf,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                    width: 1.w,
                    color: _isFileSelected
                        ? AppColors.primary
                        : AppColors.lightGrey),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 40.sp,
                        color: Colors.grey,
                      ),
                      _isFileSelected
                          ? Text(
                              _fileName!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: 'Satoshi',
                              ),
                            )
                          : Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'Unggah',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Satoshi',
                                  color: AppColors.tertiary,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' dokumen anda',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Satoshi',
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nPDF (maksimal 5 MB)',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Satoshi',
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 16.h,
                      ),
                      _isFileSelected
                          ? TextButton(
                              onPressed: _removeFile,
                              child: Text(
                                'Hapus dokumen',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.red,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
