import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodgo/models/cart_model.dart';

class CartServices {
  final CollectionReference cartCollection = FirebaseFirestore.instance
      .collection("carts");

  Future<bool?> addTocart(CartModel cartmodel) async {
    try {
      // QuerySnapshot existingItems = await cartCollection
      //     .where("productId", isEqualTo: cartmodel.productId)
      //     .where("userId", isEqualTo: cartmodel.userId)
      //     .get();

      // if (existingItems.docs.isEmpty) {
      //   DocumentSnapshot existingDocs = await existingItems.docs.first;
      //
      //   CartModel itemdata = CartModel.fromJson(
      //     existingDocs.data() as Map<String, dynamic>,
      //   );
      //
      //   itemdata.qunatity =
      //       (itemdata.qunatity ?? 1) + (cartmodel.qunatity ?? 1);
      //
      //   await cartCollection.doc(existingDocs.id).update(itemdata.toJson());
      // // } else {
      //   cartCollection.add(cartmodel.toJson());
      // }
    await  cartCollection.add(cartmodel.toJson());
      return true;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<CartModel>?> getCart() async {
    QuerySnapshot querySnapshot = await cartCollection
        .where(
          "userId",
          isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString(),
        )
        .get();

    return querySnapshot.docs
        .map(
          (value) => CartModel.fromJson(value.data() as Map<String, dynamic>),
        )
        .toList();
  }
}
