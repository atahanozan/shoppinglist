import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingList {
  String id;
  String malzeme;
  String adet;

  ShoppingList({
    required this.id,
    required this.malzeme,
    required this.adet,
  });

  factory ShoppingList.fromSnapShot(DocumentSnapshot snapshot) {
    return ShoppingList(
      id: snapshot.id,
      malzeme: snapshot['malzeme'],
      adet: snapshot['adet'],
    );
  }
}
