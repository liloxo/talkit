import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homedrawer/homedrawer_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/widget/drawerwidget/customimagecontainer.dart';
import 'package:mirshop/view/widget/drawerwidget/customlisttiledrawer.dart';
import 'package:mirshop/view/widget/drawerwidget/profilewidget/profilewidget.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomedrawerController(),
      builder: (controller){
      return Drawer(
        backgroundColor: AppColors.white,
        child: ListView(
          children: [
           CustomImageContainer(image: controller.homepageController.image),
           ProfileWidget(image: controller.homepageController.image),
           CustomListTileDrawer(icon: Icons.people, text: 'Friends', onTap: () {Get.toNamed('friendsdrawer');}),
           CustomListTileDrawer(icon: Icons.person_add_alt_1_rounded, text: 'Add Friend', onTap: () {Get.toNamed('addfrienddrawer');}),
           CustomListTileDrawer(icon: Icons.notification_add_rounded, text: 'Friends Requests', onTap: () {Get.toNamed('friendsrequests');},
           trailing: controller.isrequest ? const Icon(Icons.notification_important,color: AppColors.thirdcolor) : null),
           //CustomListTileDrawer(icon: Icons.settings, text: 'Settings', onTap: () {}),
           CustomListTileDrawer(icon: Icons.logout, text: 'Logout', onTap: () {controller.logout();})
        ])
      );
    });
  }
}