import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class VerifycodeData {
  Crud crud;
  VerifycodeData(this.crud);

  postdata(String email, String verifycode) async {
    var response = await crud.postData(LinkApi.verifycode, {
      'email': email,
      'verifycode' : verifycode,
    });
    return response.fold((l) => l, (r) => r);
  }

  resendData(String email) async {
    var response = await crud.postData(LinkApi.resend, {"email": email});
    return response.fold((l) => l, (r) => r);
  }
}