import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class CheckemailData {
  Crud crud;
  CheckemailData(this.crud);

  postdata(String email) async {
    var response = await crud.postData(LinkApi.checkemail, {
      'email': email
    });
    return response.fold((l) => l, (r) => r);  
  }
}