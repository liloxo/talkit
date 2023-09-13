import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class AcceptfriendData {
  Crud crud;
  AcceptfriendData(this.crud);

  postdata(String friendsid) async {
    var response = await crud.postData(LinkApi.acceptfriend, {'friendsid':friendsid});
    return response.fold((l) => l, (r) => r);
  }
}