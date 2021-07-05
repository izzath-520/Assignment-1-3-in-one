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
import 'package:tinder_linkedin/screens/root_app_3.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RootApp2 extends StatefulWidget {
  @override
  _RootApp2State createState() => _RootApp2State();
}

class _RootApp2State extends State<RootApp2> {

  @override
  Widget build(BuildContext context) {

  //  User user = Provider.of<User>(context);  //wtf y is this here ?

    return RootApp3();

  }


}

