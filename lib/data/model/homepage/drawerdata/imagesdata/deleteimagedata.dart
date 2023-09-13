import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class DeleteimageData {
  Crud crud;
  DeleteimageData(this.crud);

  postdata(String id,String file) async {
    var response = await crud.postData(LinkApi.deleteimage, {'id':id,'file':file});
    return response.fold((l) => l, (r) => r);
  }
}