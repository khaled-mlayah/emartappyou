import 'package:emartappyou/consts/consts.dart';

class FirestoreServices {
  // get users data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
  

  //get products accoording to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }
  // get document
  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }
  // get all chat messages 
  static getChatMessages(docId) {
    return firestore 
    .collection(chatsCollection)
    .doc(docId)
    .collection(messagesCollection)
    .orderBy('created_on',descending: false)
    .snapshots();
  }
  //get cart
  static getCart(uid){
    return firestore
    .collection(cartCollection)
    .where('p_category', isEqualTo: uid)
    .snapshots();
  }
  static getWishlists(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  }
  //delete documment 
 static getAllMessages(){
  return firestore.collection(chatsCollection).where('fromId', isEqualTo: currentUser!.uid).snapshots();
 }
 static getCounts() async {
  var res = await Future.wait([
    firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value){
     return value.docs.length;
    }),
     firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){
     return value.docs.length;
    }),
    
  ]);
  return res;
 }
 static allproducts() {
  return firestore.collection(productsCollection).snapshots();
 }
 var featuredList = [];
 getUsername()  async {
 var n = await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value){
if (value.docs.isNotEmpty){
  return value.docs.single['name'];
}
 });
 var username = n;
 }
static getFeaturedProducts() {
  return firestore.collection(productsCollection).where('is_featured',isEqualTo: true).get();
}

}
