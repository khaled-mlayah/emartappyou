import 'package:box/box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/consts/lists.dart';
import 'package:emartappyou/controllers/home.controller.dart';
import 'package:emartappyou/services/firestore_services.dart';
import 'package:emartappyou/views/cameraproduct/camera.dart';
import 'package:emartappyou/views/category_screen/item_details.dart';
import 'package:emartappyou/views/widgets_common/home_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:snapshot/snapshot.dart';

import '../Product_screen/ProductScannerScreen.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key}) : super(key: key);

  get child => null;

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator() {
      return const Center(
        
      );
    }
    var controller = Get.find<HomeController>();

    var allproducts = 'All Products';
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                height: 60,
                color: lightGrey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: whiteColor,
                              hintText: 'Search anything',
                              prefixIcon: Icon(Icons.search),
                              hintStyle: TextStyle(color: textfieldGrey),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final scannedCode = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ScanScreen()));
                            // Handle the scanned code here
                            if (scannedCode != null) {
                              // Do something with the scanned code
                            }
                          },
                          icon: const Icon(Icons.qr_code_scanner),
                        ),
                        IconButton(
                          onPressed: () async {
                            final scannedCode = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyWidget()));
                            // Handle the scanned code here
                            if (scannedCode != null) {
                              // Do something with the scanned code
                            }
                            // Add your photo selection functionality here
                            // This function will be triggered when the photo icon is tapped
                          },
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                      ],
                    ),
                  ],
                )),

            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    10.heightBox,
                    //deals buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 2.5,
                                icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                title: index == 0 ? todayDeal : flashsale,
                              )),
                    ),
                    //2nd swiper
                    10.heightBox,
                    // swipers brands
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            secondSlidersList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategories
                                    : index == 1
                                        ? brand
                                        : topSellers,
                              )),
                    ),
                    20.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(darkFontGrey)
                            .size(18)
                            .fontFamily(semibold)
                            .make()),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              featuredButton(
                                  icon: featuredImages1[index],
                                  title: featuredTitles1[index]),
                              10.heightBox,
                              featuredButton(
                                  icon: featuredImages2[index],
                                  title: featuredTitles2[index]),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),
                    //featured Prduct
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white.fontFamily(bold).size(18).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                                if (!snapshot.hasData){
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                }else if (snapshot.data!.docs.isEmpty){
                                  return "No featured products".text.white.makeCentered();
                                }else{
                                  var featuredData= snapshot.data!.docs;
                                  

                                

                              
                              return Row (
                              children: List.generate(
                               featuredData.length,
                               (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    featuredData[index]['p_imgs'][0],
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                  10.heightBox,
                                  "${featuredData[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                               
                                  10.heightBox,
                                  "${featuredData[index]['p_price']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                                  10.heightBox,
                                ],
                                
                               )
                               .box
                               .white
                               .margin(const EdgeInsets.symmetric(horizontal: 4))
                               .roundedSM
                               .padding(const EdgeInsets.all(8))
                               .make()
                               .onTap(() {
                                Get.to(()=>ItemDetails(title: "${featuredData[index]['p_name']}",
                                data: featuredData[index],
                                ));
                               })
                               ));
                                }
  }),
                          )
                        ],
                      ),

                    ),
                   
                    //third  swiper
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            secondSlidersList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    //all products
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: allproducts.text
                          .fontFamily(bold)
                          .size(18)
                          .color(darkFontGrey)
                          .make(),
                    ),
                    20.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    (allproductsdata[index]['p_imgs'].length >
                                            0)
                                        ? allproductsdata[index]['p_imgs'][0]
                                        : '', // Provide a default value or handle the case where the list is empty
                                    width: 200,
                                    height: 200,
                                  ),
                                  const Spacer(),
                                  "${allproductsdata[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsdata[index]['p_price']}"
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                  10.heightBox
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                      title:
                                          "${allproductsdata[index]['p_name']}",
                                      data: allproductsdata[index],
                                    ));
                              });
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            )

            // swipers brands
          ],
        ),
      ),
    );
  }
}
