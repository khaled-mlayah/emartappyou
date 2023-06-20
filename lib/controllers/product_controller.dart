
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var quantity = 0.obs;
  var subcat = [];
 var colorIndex = 0.obs;

  
  var totalPrice = 0.obs;
  var isFav = false.obs;
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decode = categoryModelFromJson(data);
    var s = decode.categories.where((element) => element.name == title).toList();
    for (var e in s [0].subcategory) {
      subcat.add(e);
    }
  }
  
  void changeColorIndex(int index) {
  colorIndex.value = index; // Assign the value to colorIndex using the .value property
}
  increaseQuantity(totalQuatity) {
    if (quantity.value < totalQuatity){
    quantity.value++;
  }
  }
 decreaseQuantity() {
  if (quantity.value > 0){
    quantity.value--;
  }
}
calculateTotalPrice(price) {
  totalPrice.value = price * quantity.value;
}
addToCart({title,img, sellername,color,qty,tprice,context}) async {
  await firestore.collection(cartCollection).doc().set({
    'title':title,
    'img':img,
    'sellername':sellername,
    'color':color,
    'qte':qty,
    'tprice':tprice,
    'added_by':currentUser!.uid
  }).catchError((error){
    VxToast.show(context, msg: error.toString());

  });
}
resetValues(){
  totalPrice.value=0;
  quantity.value=0;
  colorIndex.value=0;
  isFav.value = false;
}
addToWishlist(docId, context) async{
  await firestore.collection(productsCollection).doc(docId).set({
    'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])
  }, SetOptions(merge: true));
  isFav(true);
  VxToast.show(context, msg: "Added to wishlist");
}
removeFromWishlist(docId, context) async{
  await firestore.collection(productsCollection).doc(docId).set({
    'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
  }, SetOptions(merge: true));
  isFav(false);
  VxToast.show(context, msg: "Removed From wishlist");
}
checKIfFav(data) async {
  if (data['p_wishlist'].contains(currentUser!.uid)) {
    isFav(true);
  } else {
    isFav(false);
  } 
}

}