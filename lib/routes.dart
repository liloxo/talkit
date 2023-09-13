import 'package:get/get.dart';
import 'package:mirshop/view/auth/forgetpassword/resetpassword.dart';
import 'package:mirshop/view/auth/forgetpassword/verifycodeemail.dart';
import 'package:mirshop/view/auth/login.dart';
import 'package:mirshop/view/auth/signup.dart';
import 'package:mirshop/view/auth/successsignup.dart';
import 'package:mirshop/view/auth/verifycode.dart';
import 'package:mirshop/view/auth/forgetpassword/checkemail.dart';
import 'package:mirshop/view/home/homedrawer/addfrienddrawer.dart';
import 'package:mirshop/view/home/homedrawer/friendsdrawer.dart';
import 'package:mirshop/view/home/homedrawer/friendsrequests.dart';
import 'package:mirshop/view/home/homemessages/chatroom.dart';
import 'package:mirshop/view/home/homepage.dart';

List<GetPage<dynamic>>? routes = [
  //=======================Auth===========================
  GetPage(name: '/signup'       , page: ()  => const SignUp()),
  GetPage(name: '/login'        , page: ()  => const Login()),
  GetPage(name: '/verifycode'   , page: ()  => const VerifyCode()),
  GetPage(name: '/successsignup', page: ()  => const SuccessSignup()),

  //=======================ForgetPassword=================
  GetPage(name: '/checkemail'     , page: ()  => const CheckEmail()),
  GetPage(name: '/verifycodeemail', page: ()  => const VerifycodeEmail()),
  GetPage(name: '/resetpassword'  , page: ()  => const ResetPassword()),

  //=======================HomePage=======================
  GetPage(name: '/homepage', page: ()  => const HomePage()),
  //=======================Drawer=========================
  GetPage(name: '/addfrienddrawer', page: ()  => const AddFriendDrawer()),
  GetPage(name: '/friendsdrawer'  , page: ()  => const FriendsDrawer()),
  GetPage(name: '/friendsrequests', page: ()  => const FriendsRequests()),
  //=======================Messages=======================
  GetPage(name: '/chatroom', page: ()  => const ChatRoom()),


];