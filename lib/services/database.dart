import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:knebelknotes/models/userInfo.dart';

class DatabaseService {
  final String uid;
  final String email;
  DatabaseService({this.uid, this.email});
  

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      bool isAdmin, bool isStudent, String studentAccessExpires) async {
    return await userCollection.doc(email).set({
      'isAdmin': isAdmin,
      'isStudent': isStudent,
      'studentAccessExpires': studentAccessExpires
    });
  }

  //Get userunfo deom snapshot
  UserInfo _userInfoFromSnapshot(DocumentSnapshot snapshot) {
    return UserInfo(
      isAdmin: snapshot.data()['isAdmin'] ?? false,
      isStudent: snapshot.data()['isStudent'] ?? false,
      accessExpires: snapshot.data()['studentAccessExpires'] ?? DateTime.now().toString()
    );
    //return snapshot.docs.map((doc) {
    //   return UserInfo(
    //       isAdmin: doc.data()['isAdmin'] ?? false,
    //       isStudent: doc.data()['isStudent'] ?? false,
    //       accessExpires: doc.data()['studentAccessExprires'] ?? DateTime.now());
    // });
  }


  Future<DocumentSnapshot> getUserInfo() async {
    return await userCollection.doc(email).get();
  }
  //Get user Stream
  Stream<UserInfo> get users {
    //return userCollection.doc(uid).get();
    return userCollection.doc(email).snapshots().map(_userInfoFromSnapshot);
  }

}
