import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class ItemService {
  Future<void> addItem2Firebase(String docname, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("items")
        .doc(docname)
        .set(data)
        .then((value) {
      print("Item created");
    }).catchError((error) {
      print("Can't create item:" + error.toString());
    });
  }

  Future<void> editItem(BuildContext context,String documentid, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("items")
        .doc(documentid)
        .update(data)
        .then((value) {
      print("Item update");
    }).catchError((error) {
      print("Can't update item:" + error.toString());
    });
  }

  Future<void> deleteItem(
      BuildContext context, Map<String, String> data, String documentid) {
        print(documentid);
    return FirebaseFirestore.instance
        .collection("items")
        .doc(documentid)
        .delete()
        .then((value) {
      print("Item deleted");
    }).catchError((error) {
      print("Can't delete item:" + error.toString());
    });
  }
}
