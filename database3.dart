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

class DatabaseService3 {

  final String uid;
  final String postId;

  DatabaseService3({ this.uid, this.postId });

  final CollectionReference postCollection = Firestore.instance.collection(
      'the-posts');



  List<anyPost> _anyPostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return anyPost(

        url: doc.data['url'] ?? '',

      );
    }).toList();
  }

  Stream<List<anyPost>> get any_posts {
    return postCollection.document(uid).collection('userPosts').snapshots()
        .map(_anyPostListFromSnapshot);
  }
}
