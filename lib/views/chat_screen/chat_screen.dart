import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/controllers/chats_controller.dart';
import 'package:emartappyou/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'componnents/sender_bunbble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "${controller.friendName}",
          style:const TextStyle(
            fontFamily: semibold,
            color: darkFontGrey,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() => controller.isLoading.value
                ? Center(child: loadingIndicator())
                : Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadingIndicator());
                        } else if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              "Send a message....",
                              style: TextStyle(
                                color: darkFontGrey,
                              ),
                            ),
                          );
                        } else {
                          return ListView(
                            children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                              var data = snapshot.data!.docs[index];
                              return Align(
                                alignment: data['uid'] == currentUser!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: senderBubble(data),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  )),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration:const  InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      hintText: "Type a message...",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon:const Icon(
                    Icons.send,
                    color: redColor,
                  ),
                ),
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }

  Widget loadingIndicator() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
         colors: [Colors.red],
        ),
      ),
    );
  }
}
