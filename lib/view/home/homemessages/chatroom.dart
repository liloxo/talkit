import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/controller/home/homemessages/chatroom_controller.dart';
import 'package:mirshop/core/class/handlingdataview.dart';
import 'package:mirshop/core/constants/colors.dart';
import 'package:mirshop/view/widget/drawerwidget/imagedecoration.dart';
import 'package:mirshop/view/widget/messages/messagecontainer.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ChatroomController());
    return GetBuilder<ChatroomController>(
      builder: (controller){
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.thirdcolor,
          leadingWidth: double.infinity,
          leading: Row(
            children: [
              IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ImageDecoration(username: controller.friendusername,image: controller.image,icon: null)
              ),
              Text(controller.friendusername,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600))
            ]
          )
        ),
        body: Column(
          children: [
            Expanded(
              child: HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView.builder(
                reverse: true,
                controller: controller.scrollController,
                itemCount: controller.messages.length + (controller.isLoading ? 1 : 0),
                itemBuilder: (BuildContext context, int i) {
                if (controller.isLoading && i == controller.messages.length) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.thirdcolor)
                  );
                }
                String separatorText = controller.formatMessageTime(i);
                bool isNewSeparator = false; 
                if (i < controller.messages.length - 1) {
                  isNewSeparator = separatorText != controller.formatMessageTime(i + 1);
                } else {
                  isNewSeparator = true; 
                }return Column(
                    children: [
                      const SizedBox(height: 16),
                      isNewSeparator ? Text(
                        separatorText,
                        style: const TextStyle(color: Colors.grey)
                      ) : const SizedBox(),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: MessageContainer(
                            i: i,
                            onpressed: controller.whentap[i],
                            id: controller.id,
                            sender: controller.messages[i]['sender'],
                            message: controller.messages[i]['text'],
                            messagetime: controller.messageTime(i),
                          )
                        )
                    ]
                  );
                }
              )
              )
              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Material(
               elevation: 5.0,
               borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          controller.change(value);
                        },
                        controller: controller.textEditingController,
                        cursorColor: AppColors.thirdcolor,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: " Type a message", hintStyle: TextStyle(color: Colors.black45)),
                      )
                    ), 
                    Obx(() => Center(
                      child: IconButton(
                        onPressed: controller.isEmpty.value == true ? null : (){controller.sendmessage();}, 
                        icon: Icon(Icons.send, color: controller.isEmpty.value == true ? AppColors.grey : AppColors.thirdcolor))))
                  ]
                )
              )
                      ),
            )
            ]
          )
      );
    });
  }
}