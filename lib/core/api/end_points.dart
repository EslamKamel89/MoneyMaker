class EndPoint {
  static const String baseUrl = "https://money.iuceg.com/api/";
  static const String uploadUrl = "https://money.iuceg.com/";
  static const String signin = '${baseUrl}userlogin';
  static const String signup = '${baseUrl}apiuser';
  static const String getUserData = '${baseUrl}apiuser/';
  static const String _uploadFolder = '${uploadUrl}public/uploads/';
  static const String uploadUser = '${_uploadFolder}users/';
  static const String uploadPayment = '${_uploadFolder}payments/';
  static const String uploadDepositHistory = '${_uploadFolder}deposits/';
  static const String paymentMehods = '${baseUrl}apipayment';
  static const String depositHistory = '${baseUrl}apideposit/';
  static const String addDeposit = '${baseUrl}apideposit';
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
  //! get payment data
  static const String name = 'name';
  static const String code = 'code';
  static const String image = 'image';
  //! add to balance
  // static const paymentId = 'payment_id';
  static const userId = 'user_id';
  static const transactionNumber = 'process';
  static const amount = 'amount';
  // static const createdAt = 'created_at';
  // static const image = 'image';
  //! deposit history
  static const String paymentId = "payment_id";
  static const String paymentAmount = "amount";
  static const String paymentUserId = "user_id";
  static const String paymentImageOne = "image";
  static const String paymentAccepted = "accepted";
  static const String paymentProcess = "process";
  static const String paymentRefuseReason = "refuse_reason";
  static const String paymentCreatedAt = "created_at";
  static const String paymentUpdatedAt = "updated_at";
  static const String paymentFirstName = "first_name";
  static const String paymentProfileImage = "profile";
  static const String paymentName = "name";
  static const String paymentImageTwo = "payments_image";
  //  static const String = "" ;
  //  static const String = "" ;
  //  static const String = "" ;
}
