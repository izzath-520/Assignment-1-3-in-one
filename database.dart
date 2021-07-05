import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/screens/favourites_page.dart';
import 'package:tinder_linkedin/screens/info_page.dart';
//import 'package:tinder_linkedin/models/user info.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/screens/root_app.dart';
import 'package:tinder_linkedin/models/user.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';


class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('the-users');



  Future<void> updateExplorePost(String explore_post) async {
    return await userCollection.document(uid).updateData({

      'explore_post':explore_post,
      'uid': uid,

    });
  }


  List<explorePost> _userExplorePost(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return explorePost(

        url:doc.data['explore_post'] ?? '',
        uid: doc.data['uid'] ?? '',

      );
    }).toList();
  }

  Stream<List<explorePost>> get explore_posts {
    return userCollection.snapshots()
        .map(_userExplorePost);
  }






  Future<void> updateUserData(String url,String id,String username, String email, String password, String profession, String workplace) async {
    return await userCollection.document(uid).setData({
      'url': url,
      'id' : uid,
      'username': username,
      'email': email,
      'password': password,
      'profession': profession,
      'workplace': workplace,
    });
  }




  List<the_user_info> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return the_user_info(
        url:doc.data['url'] ?? '',
        id: doc.data['id'] ??'',            //maaan i made a mistake here be4, instead of doc.data n sht, i juz put uid, first of i didnt put uid only in the root app while accesssing this database, second, that uid from User, will be only logged in user, so evry time will show only current user posts fr everyone
        email: doc.data['email'] ?? '',
        username: doc.data['username'] ?? '',
        profession: doc.data['profession'] ?? '',
        workplace: doc.data['workplace'] ?? '',
        password: doc.data['password'] ?? '',
      );
    }).toList();
  }

  Stream<List<the_user_info>> get the_users {
    return userCollection.snapshots()
        .map(_userListFromSnapshot);
  }






  Future<void> updateSettings(String url,String username,String profession,String workplace) async {
    return await userCollection.document(uid).updateData({
      'url': url,
      'username': username,
      'profession': profession,
      'workplace': workplace,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        url: snapshot.data['url'],
        uid: uid,
        username: snapshot.data['username'],
        profession: snapshot.data['profession'],
        workplace: snapshot.data['workplace']
    );
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }



}