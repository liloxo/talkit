import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class FriendsrequestsData {
  Crud crud;
  FriendsrequestsData(this.crud);

  postdata(String usertwoid) async {
    var response = await crud.postData(LinkApi.friendsrequests, {'usertwo':usertwoid});
    return response.fold((l) => l, (r) => r);
  }
}