import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homedrawer/addfrienddrawer_controller.dart';
import 'package:mirshop/core/class/handlingdataview.dart';
import 'package:mirshop/core/class/statusrequest.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/widget/drawerwidget/customusercard.dart';
import 'package:mirshop/view/widget/homepagewidget/custombartextfield.dart';

class AddFriendDrawer extends StatelessWidget {
  const AddFriendDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return GetBuilder<AddfrienddrawerController>(
      init: AddfrienddrawerController(),
      builder: (controller){
      return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.secondaryColor,
            height: mediaquery.height * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: mediaquery.height * 0.05),
                Row(
                  children: [
                   SizedBox(
                    width: 25,
                    child: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back))),
                   Expanded(child: CustomBarTextField(
                    onChanged: (val){
                      controller.onSearchChanged(val);
                    },
                    controller: controller.textEditingController,color:AppColors.secondaryColor)),
                   IconButton(onPressed: (){controller.searched();}, icon: const Icon(Icons.close))
                  ]
                )
              ]
            )
          ),
          HandlingDataView(
           statusRequest: controller.statusRequest,
           widget: Expanded(
            child: controller.searchbool == false
            ? const SizedBox()
            : 
            FutureBuilder(
              future: controller.getdata(),
              builder: (context,AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  controller.statusRequest = StatusRequest.loading;
                }else {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: UserCard(searchModel: snapshot.data),
                 );
                }return const SizedBox();
              }
              )
           )
          )
        ]
      )
    );
    });
  }
}
