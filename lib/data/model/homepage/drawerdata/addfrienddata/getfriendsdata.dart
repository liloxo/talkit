import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class GetfriendsData {
  Crud crud;
  GetfriendsData(this.crud);

  postdata(String id) async {
    var response = await crud.postData(LinkApi.getfriends, {'userone':id});
    return response.fold((l) => l, (r) => r);
  }
}