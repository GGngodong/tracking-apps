part of 'upload_page.dart';

mixin UploadMixin on State<UploadPage> {

  final DateFormat dateFormat = DateFormat('dd.MM.yyyy');
  late TextEditingController _descriptionTextEditingController;
  late TextEditingController _noPermitTextEditingController;
  late DateTime _dateTextEditingController;
  late TextEditingController _categoryPermitTextEditingController;
  late TextEditingController _companyNameTextEditingController;
  late TextEditingController _noPermitMabesEditingController;
  String? _documentUrl;


  @override
  void initState() {
    _descriptionTextEditingController = TextEditingController();
    _noPermitTextEditingController = TextEditingController();
    _categoryPermitTextEditingController = TextEditingController();
    _noPermitMabesEditingController = TextEditingController();
    _companyNameTextEditingController = TextEditingController();
    _dateTextEditingController = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionTextEditingController.dispose();
    _noPermitTextEditingController.dispose();
    _categoryPermitTextEditingController.dispose();
    _noPermitMabesEditingController.dispose();
    _companyNameTextEditingController.dispose();
    super.dispose();
  }

  void _listener(UploadState state) {
    if (state is UploadSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload successful: ${state.message}')),
      );
      print('Upload successful: ${state.permit}');
    } else if (state is UploadFailed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: ${state.message}')),
      );
      print('Upload failed with error: ${state.message}');
    }
  }


  void _submit(UploadBloc uploadBloc) {
    final formattedDate = DateFormat('dd-MM-yyyy').format(_dateTextEditingController); // Format the date

    print('=======================================================');
    print('Checking document URL before submit: $_documentUrl');
    print('Description: ${_descriptionTextEditingController.text}');
    print('No Permit: ${_noPermitTextEditingController.text}');
    print('Category Permit: ${_categoryPermitTextEditingController.text}');
    print('Company Name: ${_companyNameTextEditingController.text}');
    print('No Permit Mabes: ${_noPermitMabesEditingController.text}');
    print('Selected Date: $_dateTextEditingController');
    print('=======================================================');
    String description = _descriptionTextEditingController.text.trim();
    String noPermit = _noPermitTextEditingController.text.trim();
    String categoryPermit = _categoryPermitTextEditingController.text.trim();
    String companyName = _companyNameTextEditingController.text.trim();
    String noPermitMabes = _noPermitMabesEditingController.text.trim();
    print('Document URL is valid $_documentUrl, proceeding with upload.');
    print('================== CURRENT : $uploadBloc ==================');
      uploadBloc.add(
        UploadButtonPressed(
          description: description.isEmpty ? "" : description,
          noPermit: noPermit.isEmpty ? "" : noPermit,
          date: formattedDate,
          categoryPermit: categoryPermit.isEmpty ? "" : categoryPermit,
          companyName: companyName.isEmpty ? "" : companyName,
          noPermitMabes: noPermitMabes.isEmpty ? null  : noPermitMabes,
          documentUrl: _documentUrl!,
        ),
      );
  }

  Widget buildPdfPicker() {
    return PdfUpload(
      header: 'Upload Document',
      onFileSelected: (String? filePath) {
        setState(() {
          _documentUrl = filePath ?? '';
          print('============== PDF UPLOAD FILE : $filePath ==============');
        });
        Future.delayed(Duration(milliseconds: 100), () {
          print('Updated document URL: $_documentUrl');
        });
      },
    );
  }
}

