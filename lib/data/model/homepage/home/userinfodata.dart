import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class UserinfoData {
  Crud crud;
  UserinfoData(this.crud);

  postdata(String id) async {
    var response = await crud.postData(LinkApi.userinfo, {
      'id': id,
    });
    return response.fold((l) => l, (r) => r);
  }
}