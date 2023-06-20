

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartappyou/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../../services/firestore_services.dart';
import '../widgets_common/bg_widget.dart';
import 'item_details.dart';

class CategoryDetails extends StatelessWidget{
  final String? title;
  const CategoryDetails({key,required this.title}):super(key: key);
  @override
  Widget build(BuildContext context){
    Widget loadingIndicator() {
  return const CircularProgressIndicator();
}
    var controller =Get.find<ProductController>();
    return bgWidget(
      child:Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) {
              return  Center(
               child: loadingIndicator(),
              );
            }else if (snapshot.data!.docs.isEmpty){
             return Center(
              child: "No products found!".text.color(darkFontGrey).make(),
             );
            }else{
              var data = snapshot.data!.docs;
              return Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: 
                          
                          List.generate(
                            controller.subcat.length,
                            (index)=> "${controller.subcat[index]}"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .rounded
                            .size(120, 50)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .make())),
                  
                  
                          ),
                  
                  
                          20.heightBox,
                          Expanded(
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8
                              ),
                              itemBuilder: (context, index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      height: 160,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ).box.roundedSM.clip(Clip.antiAlias).make(),
                                    5.heightBox,
                                    "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).makeCentered(),
                                    10.heightBox,
                                    "${data[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).makeCentered(),
                                    10.heightBox,
                                  ],
                                )
                                .box
                                .white
                                .margin(const EdgeInsetsDirectional.symmetric(horizontal: 4))
                                .roundedSM
                                .outerShadowSm
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                                  controller.checKIfFav(data[index]);

                                  Get.to(
                                    ()=>  ItemDetails
                                    (title: "${data[index]['p_name']}",
                                    data: data[index]));
                                });
                              })),
                          
                        ],
                        
                      ),
                    );
            
            }
          },
        ),
          
            
                  
               
             
            
    )); 
  
  }
  

}



          


        

        
    

