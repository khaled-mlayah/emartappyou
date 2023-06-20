import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:  
          "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
         
           
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 
             
                "No Wishlists yet!".text.color(darkFontGrey).makeCentered();
               
                 
                
            
            
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context,int index) {
                return ListTile(
                  leading: Image.network(
                    "${data[index]['p_imgs'][0]}",
                    width: 80 ,
                    fit: BoxFit.cover,
                  ),
                  title: "${data[index]['p_name']}".text.fontFamily(semibold).size(16).make(),
                  subtitle: "${data[index]['p_price']}".text.color(redColor).fontFamily(semibold).make(),
                  trailing: const Icon(
                    Icons.favorite,
                    color: redColor,
                  ).onTap(() async {
                    await firestore.collection(productsCollection).doc(data[index].id).set({
                      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                    },SetOptions(merge: true));
                  }),
                );
              },
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
