import 'package:cloud_firestore/cloud_firestore.dart';

class the_user_info {     //for any user's information
  String url;
  String id;
  String email;
  String username;
  String profession;
  String workplace;
  String password;

  the_user_info({
    this.url,
    this.id,
    this.email,
    this.username,
    this.profession,
    this.workplace,
    this.password,

  });

  factory the_user_info.fromDoc(DocumentSnapshot doc) {
    return the_user_info(
      id: doc['id'],
      username: doc['username'],
      email: doc['email'],
      profession: doc['profession'],
      workplace: doc['workplace'],
      password: doc['password'],
      url: doc['url']
    );
  }


}




class explorePost {        //for any user's explore_post
  String url;
  String uid;
  explorePost({this.url,this.uid});
}