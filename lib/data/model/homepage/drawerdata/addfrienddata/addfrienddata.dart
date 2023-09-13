import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class AddfriendData {
  Crud crud;
  AddfriendData(this.crud);

  postdata(String useroneid,String usertwoid) async {
    var response = await crud.postData(LinkApi.addfriend, {'userone':useroneid,'usertwo':usertwoid});
    return response.fold((l) => l, (r) => r);
  }
}