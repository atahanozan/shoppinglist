import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/model/shoppinglist.dart';

class ShoppingListService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<ShoppingList> addList(
    String malzeme,
    String adet,
  ) async {
    var ref = _firebaseFirestore.collection('ShoppingList');

    var documentRef = await ref.add({
      'malzeme': malzeme,
      'adet': adet,
    });

    return ShoppingList(
      id: documentRef.id,
      malzeme: malzeme,
      adet: adet,
    );
  }

  Stream<QuerySnapshot> getList() {
    var ref = _firebaseFirestore.collection('ShoppingList').snapshots();

    return ref;
  }

  Future<void> removeList(String docId) {
    var ref = _firebaseFirestore.collection('ShoppingList').doc(docId).delete();

    return ref;
  }
}
