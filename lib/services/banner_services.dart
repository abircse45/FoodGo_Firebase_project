import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodgo/models/banner_model.dart';
import 'package:foodgo/models/product_model.dart';

class BannerServices {
  final CollectionReference productcollection = FirebaseFirestore.instance
      .collection("banners");

  Future createbanners(BannerModel productmodel) async {
    await productcollection.add(productmodel.toJson());
  }

  Future<List<BannerModel>> getAllbanner() async {
    final snapshot = await productcollection.get();

    return snapshot.docs
        .map(
          (value) => BannerModel.fromJson(
        value.data() as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future updateBanner(BannerModel productModel) async {
    await productcollection.doc(productModel.id).update(productModel.toJson());
  }

  Future deletebanner(String id) async {
    await productcollection.doc(id).delete();
  }
}
