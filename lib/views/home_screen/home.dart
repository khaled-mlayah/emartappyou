

import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/controllers/home.controller.dart';
import 'package:emartappyou/views/category_screen/category_screen.dart';
import 'package:emartappyou/views/home_screen/home_screen.dart';
import 'package:emartappyou/views/profile_screen/profile_screen.dart';
import 'package:emartappyou/views/widgets_common/exit_dialog.dart';
import 'package:emartappyou/views/wishlist_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key?key}):super (key: key);

  @override
  Widget build(BuildContext context) {
    var controller =Get.put(HomeController());
  var navbarItem= [
    BottomNavigationBarItem(icon: Image.asset(icHome,width: 26),label:home),
    BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26),label:categories),
    BottomNavigationBarItem(icon: Image.asset(icHeart,width: 26),label:Favoris,
    ),

    BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26),label:account),
    
  ];
  var navBody=[
    const HomeScreen(),
    const CategoryScreen(),
    const WishlistScreen(),
    const ProfileScreen(),
    ];
  return WillPopScope(
    onWillPop: () async {
      showDialog(
        barrierDismissible: false,
        context: context,
         builder: (context)=> exitDialog(context));
      return false;
    },
    child: Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItem,
          onTap: (value) {
            controller.currentNavIndex.value=value;
          },
        ),
      
      ),
        
        
        
        
  
      
    ),
  );
  
  
  }
}