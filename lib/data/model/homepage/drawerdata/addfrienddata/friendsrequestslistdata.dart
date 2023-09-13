import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class FriendsrequestslistData {
  Crud crud;
  FriendsrequestslistData(this.crud);

  postdata(String usertwoid) async {
    var response = await crud.postData(LinkApi.friendsrequestslist, {'usertwo':usertwoid});
    return response.fold((l) => l, (r) => r);
  }
}