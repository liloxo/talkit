import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homedrawer/friendsrequests_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/data/datasource/friends/friendslistmodel.dart';
import 'package:mirshop/view/widget/drawerwidget/imagedecoration.dart';

class RequestUserCard extends StatelessWidget {
  final List<FriendsListModel> userModel;
  const RequestUserCard({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    FriendsrequestsController controller = Get.put(FriendsrequestsController());
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: userModel.length,
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
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                child: ImageDecoration(image: userModel[i].useroneImage,username: userModel[i].useroneUsername,icon: null),
              ),
              Text(userModel[i].useroneUsername!,style: const TextStyle(fontSize: 17,color: AppColors.black,fontWeight: FontWeight.w500))
             ]),
             Padding(
               padding: const EdgeInsets.only(right: 10),
               child: Row(
                children: [
                  TextButton(
                    onPressed: (){controller.acceptfriend(userModel[i].friendsId.toString(),userModel[i].useroneId.toString(),userModel[i].useroneUsername!,userModel[i].useroneImage);}, 
                    child: const Text('confirm',style: TextStyle(color: AppColors.thirdcolor,fontSize: 17))),
                  TextButton(onPressed: (){controller.deletefriend(userModel[i].friendsId.toString());}, child: const Text('remove'))
                ]
               ),
             )
            ]
          )
        )
      );
      },
      );
  }
}