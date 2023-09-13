import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {

  if (val.isEmpty) {
    return "Field can't be Empty";
  }else{
    if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "not valid username";
     }
    }
   if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "not valid email";
    }
   }
  }

  if (val.length < min) {
    return "can't be less than $min";
  }

  if (val.length > max) {
    return "can't be larger than $max";
  }
}