class BaseUrl {
  static const baseUrl = 'http://192.168.11.69:8000';

  // static const baseUrl = 'http://192.168.1.10:8000';
  // USER
  static const register = '$baseUrl/api/dev/users';
  static const login = '$baseUrl/api/dev/users/login';
  static const getUser = '$baseUrl/api/dev/current';
  static const deleteUser = '$baseUrl/api/dev/users/logout';

  //
  static const uploadPermit = '$baseUrl/api/dev/permit-letters/upload';
  static const getPermit = '$baseUrl/api/dev/permit-letters/';
  static const getPermitById = '$baseUrl/api/dev/permit-letters/';
  static const searchPermit = '$baseUrl/api/dev/permit-letters/search';
  static const editPermit = '$baseUrl/api/dev/permit-letters/edit/';
  static const deletePermit = '$baseUrl/api/dev/permit-letters/delete/';
}
