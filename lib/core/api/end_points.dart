class EndPoint {
  static const String baseUrl = "https://money.iuceg.com/api/";
  static const String uploadUrl = "https://money.iuceg.com/";
  static const String signin = '${baseUrl}userlogin';
  static const String signup = '${baseUrl}apiuser';
  static const String getUserData = '${baseUrl}apiuser/';
  static const String _uploadFolder = '${uploadUrl}public/uploads/';
  static const String uploadUser = '${_uploadFolder}users/';
  // static const String f = '';
  // static const String f = '';
  // static const String f = '';
  // static const String f = '';
  // static const String f = '';
}

class ApiKey {
  //! main keys
  static const String data = "data";
  static const String status = "status";
  static const String error = "error";
  static const String messageAr = "messageAr";
  static const String messageEn = "messageEn";
  static const String success = "success";
  static const String fail = "fail";
  //! getUserData - signup
  static const String id = "id";
  static const String fullName = "last_name";
  static const String userName = "first_name";
  static const String gender = "gender";
  static const String email = "email";
  static const String mobile = "mobile";
  static const String emailVerifiedAt = "email_verified_at";
  static const String password = "password";
  static const String profile = "profile";
  static const String passport = "passport";
  static const String passportBack = "passport_back";
  static const String levelId = "level_id";
  static const String rememberToken = "remember_token";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  //! signin
  static const String user = "user";

  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
}
