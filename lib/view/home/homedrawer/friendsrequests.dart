import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homedrawer/friendsrequests_controller.dart';
import 'package:mirshop/core/class/handlingdataview.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/widget/drawerwidget/friendsrequests/requestusercard.dart';

class FriendsRequests extends StatelessWidget {
  const FriendsRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
      toolbarHeight: mediaquery.height * 0.09,
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: AppColors.grey,size: 27)),
      centerTitle: true,
      title: const Text('Requests',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: AppColors.grey))
     ),
     body: GetBuilder<FriendsrequestsController>(
      init: FriendsrequestsController(),
      builder: (controller){
      return HandlingDataView(
      statusRequest: controller.statusRequest, 
      widget: FutureBuilder(
        future: controller.getrequestslist(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(color: AppColors.thirdcolor));
          }else if(snapshot.hasData){
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: RequestUserCard(userModel: controller.users),
           );
          }else{
            return const SizedBox();
          }
        }
      ));
     }),
    );
  }
}