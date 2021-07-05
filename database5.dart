import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_linkedin/models/user.dart';


class DatabaseService5 {

  final String uid;
  DatabaseService5({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('the-users');
  final CollectionReference followingRef = Firestore.instance.collection('following');
  final CollectionReference followersRef = Firestore.instance.collection('followers');


  Future<int> followersNum(String userId) async {
    QuerySnapshot followersSnapshot =
    await followersRef.document(userId).collection('Followers').getDocuments();
    return followersSnapshot.documents.length;
  }

  Future<QuerySnapshot> searchUsers(String name) async {     //it was static Future<...>,
    Future<QuerySnapshot> users = userCollection             //in this version, changed to just Future<...>
        .where('username', isGreaterThanOrEqualTo: name)     //so is for all the following methods
        .where('username', isLessThan: name + 'z')
        .getDocuments();                                     //also, from get() to getDocuments()

    return users;
  }






  void followUser(String currentUserId, String visitedUserId) {
    followingRef
        .document(currentUserId)                           //also, from doc to document
        .collection('Following')
        .document(visitedUserId)
        .setData({});                                     //also, from set({}) to setData
    followersRef
        .document(visitedUserId)
        .collection('Followers')
        .document(currentUserId)
        .setData({});

  //  addActivity(currentUserId, null, true, visitedUserId);
  }

  void unFollowUser(String currentUserId, String visitedUserId) {
    followingRef
        .document(currentUserId)
        .collection('Following')
        .document(visitedUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    followersRef
        .document(visitedUserId)
        .collection('Followers')
        .document(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  Future<bool> isFollowingUser(
      String currentUserId, String visitedUserId) async {
    DocumentSnapshot followingDoc = await followersRef
        .document(visitedUserId)
        .collection('Followers')
        .document(currentUserId)
        .get();                       //note, under document its get()
    return followingDoc.exists;       //earlier, under collection, it was getDocuments() (in searchUsers)
  }




}