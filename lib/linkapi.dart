class LinkApi {

  static const String linkServer = 'https://mirtalkit.000webhostapp.com/talkit';
  static const String linkServerImages = 'https://mirtalkit.000webhostapp.com/talkit/upload';

  //======================Auth=============================
  static const String login      = '$linkServer/auth/login.php';
  static const String signup     = '$linkServer/auth/signup.php';
  static const String verifycode = '$linkServer/auth/verifycode.php';
  static const String resend     = "$linkServer/auth/resend.php";
  //======================ForgetPassword===================
  static const String checkemail      = '$linkServer/forgetpassword/checkemail.php';
  static const String resetpassword   = '$linkServer/forgetpassword/resetpassword.php';
  static const String verifycodeemail = '$linkServer/forgetpassword/verifycodeemail.php';
  //======================UserImage========================
  static const String uploadimage      = '$linkServer/userimage/uploadimage.php';
  static const String deleteimage      = '$linkServer/userimage/deleteimage.php';
  //======================UserInfo=========================
  static const String userinfo        = '$linkServer/userinfo/info.php';
  //======================AddFriend========================
  static const String searchfriend        = '$linkServer/addfriend/searchfriend.php';
  static const String addfriend           = '$linkServer/addfriend/addfriend.php';
  static const String acceptfriend        = '$linkServer/addfriend/acceptfriend.php';
  static const String friendsrequests     = '$linkServer/addfriend/friendsrequests.php';
  static const String friendsrequestslist = '$linkServer/addfriend/friendsrequestslist.php';
  static const String getfriends          = '$linkServer/addfriend/getfriends.php';
  static const String deletefriend        = '$linkServer/addfriend/deletefriend.php';


}