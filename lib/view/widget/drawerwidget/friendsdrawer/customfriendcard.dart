import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homedrawer/friendsdrawer_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/data/datasource/friends/friendsmodel.dart';
import 'package:mirshop/view/widget/drawerwidget/imagedecoration.dart';

class FriendCard extends StatelessWidget {
  final List<FriendModel> friendmodel;
  const FriendCard({Key? key, required this.friendmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    FriendsdrawerController controller = Get.put(FriendsdrawerController());
    return ListView.builder(
      itemCount: friendmodel.length,
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
                child: ImageDecoration(image: friendmodel[i].otherImage,username: friendmodel[i].otherUsername,icon: null),
              ),
              Text(friendmodel[i].otherUsername!,style: const TextStyle(fontSize: 22,color: AppColors.black,fontWeight: FontWeight.w500)),
             ]),
             Padding(
               padding: const EdgeInsets.only(right: 10),
               child: TextButton(onPressed: (){controller.deletefriend(friendmodel[i].friendsId.toString());}, child: const Text('remove')),
             ),
            ]
          )
        )
      );
     },
    );
  }
}