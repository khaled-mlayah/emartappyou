
import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/consts/lists.dart';
import 'package:emartappyou/views/category_screen/category_details.dart';
import 'package:emartappyou/views/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
          appBar: AppBar(
           title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      categories.text.fontFamily(bold).white.make(),
      Ink(
        decoration:const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Add button action
          },
          child:const  Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  ),
),




          body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent:250 
              ),
              itemBuilder: (context,index){
                return Column(
                  children: [
                    Image.asset(categoryImages[index],height: 150,width: 200,fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),

                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                  controller.getSubCategories(categoriesList[index]);
                  Get.to(()=>CategoryDetails(title: categoriesList[index]) );
                });
              }),
          ),
        )
    );
  }
}