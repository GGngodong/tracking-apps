part of 'edit_page.dart';

mixin EditMixin on State<EditPage> {
  late TextEditingController _noPermitMabesTextEditingController;
  late TextEditingController _statusProcessTextEditingController;
  late TextEditingController _uploadStatusTextEditingController;
  late TextEditingController _noteTextEditingController;
  late String? _authToken;

  @override
  void initState() {
    super.initState();
    _uploadStatusTextEditingController = TextEditingController();
    _statusProcessTextEditingController = TextEditingController();
    _noPermitMabesTextEditingController = TextEditingController();
    _noteTextEditingController = TextEditingController();
    _loadAuthToken();
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

  @override
  void dispose() {
    _uploadStatusTextEditingController.dispose();
    _statusProcessTextEditingController.dispose();
    _noPermitMabesTextEditingController.dispose();
    _noteTextEditingController.dispose();
    super.dispose();
  }

  void _fetchPermitLetters() {
    if (_authToken != null) {
      context
          .read<DetailPermitLetterBloc>()
          .add(GetDetailPermitLetterEvent(id: widget.id));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid ID or missing authentication token.')),
      );
    }
  }

  void _listener(EditState state) {
    if (state is EditSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update Successful!')),
      );
      Navigator.pop(context);
      print('Update successful: ${state.permit}');
    } else if (state is EditFailedState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update failed: ${state.message}')),
      );
      print('Update failed with error: ${state.message}');
    }
  }

  void _submit(EditBloc editBloc) {
    print('=======================================================');
    print('Upload Status: ${_uploadStatusTextEditingController.text}');
    print('Status Tahapan: ${_statusProcessTextEditingController.text}');
    print('No Permit Mabes: ${_noPermitMabesTextEditingController.text}');
    print('================== CURRENT : $editBloc ==================');
    editBloc.add(
      UpdateDataButtonPressed(
        id: widget.id,
        noProdukMabes: _noPermitMabesTextEditingController.text.trim(),
        processStatus: _statusProcessTextEditingController.text.trim(),
        uploadStatus: _uploadStatusTextEditingController.text.trim(),
        note: _noteTextEditingController.text.trim(),
      ),
    );
  }
}
