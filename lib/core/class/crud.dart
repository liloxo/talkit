import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Crud {

  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
   if(await checkInternet()){
    var response = await http.post(Uri.parse(linkurl),body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
     Map responsebody = jsonDecode(response.body);
    return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
   }else{
    return const Left(StatusRequest.offlinefailure);
   }
  }

  Future<Either<StatusRequest, Map>> postDatawithfile(String linkurl, Map data,File file) async {
   if(await checkInternet()){
    var request = http.MultipartRequest('POST',Uri.parse(linkurl));

    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartfile = http.MultipartFile('file',stream,length,filename: basename(file.path));

    request.files.add(multipartfile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);

    if (response.statusCode == 200 || response.statusCode == 201) {
     Map responsebody = jsonDecode(response.body);
    return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
   }else{
    return const Left(StatusRequest.offlinefailure);
   }
  }

}