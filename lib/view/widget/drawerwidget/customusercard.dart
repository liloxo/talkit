import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homedrawer/addfrienddrawer_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/data/datasource/friends/searchfriendmodel.dart';
import 'package:mirshop/view/widget/drawerwidget/imagedecoration.dart';

class UserCard extends StatelessWidget {
  final List<SearchModel> searchModel;
  const UserCard({Key? key, required this.searchModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    AddfrienddrawerController controller = Get.put(AddfrienddrawerController());
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: searchModel.length,
      itemBuilder: (BuildContext context, int i) {
      return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
          height: mediaquery.height * 0.12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Row(children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: ImageDecoration(image: searchModel[i].image,username: searchModel[i].username,icon: null),
              ),
              Text(searchModel[i].username!,style: const TextStyle(fontSize: 20,color: AppColors.black,fontWeight: FontWeight.w500))
             ]),
             searchModel[i].friendshipStatus == 'already friends'
             ? const Padding(
               padding: EdgeInsets.only(right: 8),
               child: Icon(Icons.check),
             )
             : IconButton(onPressed: (){
              controller.addfriend(searchModel[i].id.toString());
             }, icon: const Icon(Icons.person_add_alt,size: 30))
            ]
          )
        )
      );
      },
      );
  }
}