import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class DeletefriendData {
  Crud crud;
  DeletefriendData(this.crud);

  postdata(String id) async {
    var response = await crud.postData(LinkApi.deletefriend, {'friendsid':id});
    return response.fold((l) => l, (r) => r);
  }
}