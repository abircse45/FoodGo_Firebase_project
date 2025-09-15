import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodgo/models/order_model.dart';

class OrderServices {
  final CollectionReference orderCOllection = FirebaseFirestore.instance
      .collection("ordes");

  Future placeOrder(OrderModel orderModel) async {
    await orderCOllection.add(orderModel.toJson());
  }


  Future<List<OrderModel>?> getOrder() async {
    try {
      QuerySnapshot snap = await orderCOllection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      return snap.docs
          .map((d) => OrderModel.fromJson(d.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
