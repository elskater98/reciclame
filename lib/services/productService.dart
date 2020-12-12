import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  static final ProductService instance = ProductService._internal();

  ProductService._internal();

  factory ProductService() => instance;

  getAllProducts() async {
    var snapshot = await FirebaseFirestore.instance.collection('product').get();

    List res = new List();

    snapshot.docs.forEach((doc) {
      res.add(doc.data());
    });

    return res;
  }

  getByName(name, {lang = "en"}) async {
    var queryVal = lang == "es" ? "name_ES" : "name";
    var snapshot = await FirebaseFirestore.instance
        .collection('product')
        .orderBy(queryVal)
        .where(queryVal, isGreaterThanOrEqualTo: name)
        .where(queryVal, isLessThanOrEqualTo: name + '\uf8ff')
        .get();

    List<dynamic> res = new List<dynamic>();

    snapshot.docs.forEach((doc) {
      res.add(doc.data());
    });

    return res;
  }
}
