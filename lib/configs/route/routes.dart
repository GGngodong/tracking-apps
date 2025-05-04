enum Routes {
  initial('/'),
  navigation('/navigation'),
  homePage('/home'),
  statusPage('/status'),
  search('/search'),
  uploadData('/upload'),
  notification('/notification'),
  login('/login'),
  register('/register'),
  listPermit('/list_permit'),
  rejection('/rejection'),
  verify('/verify'),
  profile('/profile'),
  settings('/settings'),
  updatePassword('/update_password');

  final String path;

  const Routes(this.path);
}
