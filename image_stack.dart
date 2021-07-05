import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/screens/info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_linkedin/models/database.dart';



class imageStack extends StatefulWidget {
  @override

  String userImage;
  String uid;

  imageStack({this.userImage,this.uid});

  _imageStackState createState() => _imageStackState();
}

class _imageStackState extends State<imageStack> {
  @override
  Widget build(BuildContext context) {

    final the_users = Provider.of<List<the_user_info>>(context) ??[];
    the_user_info this_user = the_users.firstWhere((element) => element.id == widget.uid,orElse: () => null);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          info_page.routename,
          arguments: this_user,
        );
      },
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          widget.userImage,
        ),
      ),
    );
  }
}

