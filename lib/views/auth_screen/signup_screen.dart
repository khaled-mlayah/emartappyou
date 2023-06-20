
import 'dart:math';

import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/controllers/auth_controller.dart';
import 'package:emartappyou/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/lists.dart';
import '../widgets_common/applogo_widget.dart';
import '../widgets_common/bg_widget.dart';
import '../widgets_common/custom_textfield.dart';
import '../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key?key}):super(key: key);

  @override
  State<SignupScreen> createState()=> _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>  {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // text controllers 
  var nameConroller = TextEditingController();
  var emailConroller = TextEditingController();
  var passwordConroller = TextEditingController();
  var passwordRetypeConroller = TextEditingController();

  
    @override
 Widget build(BuildContext context) {
   return bgWidget(
     child: Scaffold(
       resizeToAvoidBottomInset: false,
       body: Center(
         child: Column(
         children: [
           (context.screenHeight*0.1).heightBox,
           applogoWidget(),
           10.heightBox,
           "Join the  $appname".text.fontFamily(bold).white.size(18).make(),
           15.heightBox,
           Obx(()=>
              Column(
               children: [
                 customTextField(hint:nameHint,title: name,controller: nameConroller,isPass: false),
                 customTextField(hint:emailHint,title: email,controller: emailConroller,isPass:false ),
                 customTextField(hint: passwordHint,title: password,controller: passwordConroller,isPass: true),
                 customTextField(hint: passwordHint,title: retypePasword,controller: passwordRetypeConroller,isPass: true),
                 Align(
                   alignment: Alignment.centerRight,
                   child: TextButton(onPressed: () {},child: forgetPass.text.make(),),),
                  
                   Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value:isCheck,
                       
                        onChanged: (newValue){
                          setState(() {
                            isCheck=newValue;
                          });
                          
                        },
                      ),
                      10.widthBox,
                      Expanded(
                      child: RichText(
                        text:const  TextSpan(
                        children: [
                          TextSpan(
                            text: "I agree to the",
                            style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,
                          )),
                          TextSpan(
                          text: termAndCond,
                           style: TextStyle(
                           fontFamily: regular,
                           color: redColor,
                          )),
                          TextSpan(
                            text: "&",
                             style: TextStyle(
                             fontFamily: regular,
                             color: fontGrey,
                            )),
                            TextSpan(
                             text: privacyPolicy,
                              style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                             ))
                        ],
                      )),
                      ),
                    ],
                   ),
                  5.heightBox,
                  // ourButton().box.width(context.screenWidth -50).make(),
                 controller.isloading.value?   
                 const CircularProgressIndicator(
   valueColor: AlwaysStoppedAnimation(redColor),
 ): ourButton(
                    color:isCheck==true?
                     redColor:lightGrey,
                     title:signup,
                     textColor: whiteColor,
                     onPress: () async {
                      if (isCheck !=false) {
                        controller.isloading(true);
                        try {
                          await controller
                          .signupMethod(context: context,email:emailConroller.text,password: passwordConroller.text)
                            .then((value) {
                              
                              return controller.storeUserData(
                                email: emailConroller.text,
                                password: passwordConroller.text,
                                name: nameConroller.text
           
                              );
           
                            }).then((value) {
                              VxToast.show(context, msg:loggedin );
                              Get.offAll(() => const  Home());
                            });
                        } catch (e) {
                          auth.signOut();
                          VxToast.show(context, msg: e.toString());
                          controller.isloading(false);
                        }
                      }
           
                     },)
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
                  10.heightBox,
                  //wrapping into gesture detector of velocity x
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      }),
                        
                    ],
                  ),
                   
                   
               ],
             ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
           ),
           
         ],
       ),
     ),
   ));
 }
}
  
