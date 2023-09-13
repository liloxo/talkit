import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);

  postdata(String username,String email, String password) async {
    var response = await crud.postData(LinkApi.signup, {
     'username' : username,
     'email'    : email,
     'password' : password
    });
    return response.fold((l) => l, (r) => r);
  }
}