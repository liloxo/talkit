import 'dart:io';
import 'package:mirshop/core/class/crud.dart';
import 'package:mirshop/linkapi.dart';

class UploadimageData {
  Crud crud;
  UploadimageData(this.crud);

  postdata(String id,File? file) async {
    var response = await crud.postDatawithfile(LinkApi.uploadimage, {'id':id}, file!);
    return response.fold((l) => l, (r) => r);
  }
}