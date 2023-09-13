import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homemessages/chatroom_controller.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/widget/messages/messagebottomsheet.dart';

class MessageContainer extends StatelessWidget {
  final String message;
  final String sender;
  final String id;
  final String messagetime;
  final bool onpressed;
  final int i;
  const MessageContainer({super.key, required this.message, required this.sender, required this.id, required this.messagetime, required this.onpressed, required this.i});

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    Get.put(ChatroomController());
    return GetBuilder<ChatroomController>(
      builder: (controller){ 
        return GestureDetector(
        onTap: () {
          controller.showview(i);
        },
        onLongPress: () {
          whenpressedlong(
            message,
            (){controller.deletemessage(controller.messages[i].id,i).then((value) => Get.back());},
            sender == id ? true : false
            );
        },
       // onLongPress: () {controller.whenpressedlong(message,(){controller.deletemessage(controller.messages[i].id,i).then((value) => Get.back());});},
        child: Wrap(
          alignment: sender == id ? WrapAlignment.end : WrapAlignment.start,
          children: [
            Container(
              margin: sender == id ? EdgeInsets.only( left:  mediaquery.width * 0.3 ) : EdgeInsets.only( right:  mediaquery.width * 0.3 ),
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 7),
              decoration: BoxDecoration(
               color: sender == id ? AppColors.thirdcolor : AppColors.grey,
               borderRadius: sender == id ?
               const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8)
                )
                : const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8)
                )
              ),
              child: Text(message,textAlign: TextAlign.start,style: const TextStyle(color: AppColors.white,fontSize: 18)),
            ),
            Container(
             alignment: sender == id ? Alignment.bottomRight : Alignment.bottomLeft,
             child: Row(
              mainAxisAlignment: sender == id ? MainAxisAlignment.end : MainAxisAlignment.start,
               children: [
                 Text(messagetime,textAlign: TextAlign.start,style: const TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.w600)),
                 controller.messages[i]['sender'] == controller.id 
                  ? controller.whentap[i] ? Text(controller.messageview(i),style: const TextStyle(fontSize: 15,color: AppColors.grey)) : const SizedBox()
                  : const SizedBox()
               ],
             )),
          ]
        ),
      );
      }
    );
  }
}