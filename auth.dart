import 'package:tinder_linkedin/models/user.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:tinder_linkedin/models/database4.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  // sign in anon
 // Future signInAnon() async {
 //   try {
//      AuthResult result = await _auth.signInAnonymously();
//      FirebaseUser user = result.user;
 //     return _userFromFirebaseUser(user);
 //   } catch (e) {
//      print(e.toString());
  //    return null;
//    }
 // }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(File userImageFile,String email,String username,String profession,String workplace,String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;



      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(user.uid + '.jpg');

      await ref.putFile(userImageFile).onComplete;
      final url = await ref.getDownloadURL();



      await DatabaseService(uid: user.uid).updateUserData(url,user.uid,username,email, password,profession,workplace);

      String description = '';
      await DatabaseService4(uid: user.uid).updateDescription(description);

      return _userFromFirebaseUser(user); //guessnote: not 'return user' like earlier w/ signin
    } catch (error) {                     //           cuz here now only user is going to get id,
      print(error.toString());            //           wasn't already there...
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}