import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class VerifycodeemailData {
  Crud crud;
  VerifycodeemailData(this.crud);

  postdata(String email,String verifycode) async {
    var response = await crud.postData(LinkApi.verifycodeemail, {
      'email': email,
      'verifycode':verifycode
    });
    return response.fold((l) => l, (r) => r);  
  }
}