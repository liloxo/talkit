import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class SearchfriendData {
  Crud crud;
  SearchfriendData(this.crud);

  postdata(String username,String id) async {
    var response = await crud.postData(LinkApi.searchfriend, {'username':username,'id':id});
    return response.fold((l) => l, (r) => r);
  }
}