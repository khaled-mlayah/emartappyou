import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/controllers/cart_controller.dart';
import 'package:emartappyou/services/firestore_services.dart';
import 'package:emartappyou/views/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network("${data[index]['img']}"),
                          title: "${data[index]['title']} (x${data[index]['qty']})"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(() => "${controller.totalP.value}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make()),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightGolden)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                      color: redColor,
                      onPress: () {},
                      textColor: whiteColor,
                      title: "Proceed to shipping",
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget loadingIndicator() {
    return const Center(
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulse,
       colors: [Colors.blue],
      ),
    );
  }
}
