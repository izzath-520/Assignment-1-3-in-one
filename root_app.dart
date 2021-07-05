import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/screens/favourites_page.dart';
import 'package:tinder_linkedin/screens/info_page.dart';
//import 'package:tinder_linkedin/models/user info.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:tinder_linkedin/models/user.dart';
import 'package:tinder_linkedin/screens/my account body.dart';
import 'package:tinder_linkedin/models/settings_form.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_linkedin/screens/root_app_2.dart';


class RootApp extends StatefulWidget {

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {


  @override
  Widget build(BuildContext context) {


    return StreamProvider<List<the_user_info>>.value(  //here we provide
      value: DatabaseService().the_users,              //list of users,
                                                       //of type the-user-info
      child: RootApp2()
    );
  }

}

