enum Routes {
  initial('/'),
  navigation('/navigation'),
  homePage('/home'),
  uploadData('/upload'),
  notification('/notification'),
  login('/login'),
  register('/register'),
  listPermit('/list_permit'),
  verify('/verify'),
  profile('/profile'),
  settings('/settings'),
  updatePassword('/update_password'),
  ;

  final String path;
  const Routes(this.path);
}
