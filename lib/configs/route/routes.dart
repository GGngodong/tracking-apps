enum Routes {
  initial('/'),
  navigation('/navigation'),
  homePage('/home'),
  uploadData('/upload'),
  notification('/notification'),
  login('/login'),
  register('/register'),
  verify('/verify'),
  profile('/profile'),
  settings('/settings'),
  updatePassword('/update_password'),
  ;

  final String path;
  const Routes(this.path);
}
