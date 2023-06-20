import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartappyou/consts/colors.dart';
import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "My Orders",
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No orders yet!",
                style: TextStyle(
                  color: darkFontGrey,
                ),
              ),
            );
          } else {
            return Container();
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
