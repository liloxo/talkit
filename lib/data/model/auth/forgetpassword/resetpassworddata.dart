import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class ResetpasswordData {
  Crud crud;
  ResetpasswordData(this.crud);

  postdata(String email,String password) async {
    var response = await crud.postData(LinkApi.resetpassword, {
      'email': email,
      'password':password
    });
    return response.fold((l) => l, (r) => r);  
  }
}