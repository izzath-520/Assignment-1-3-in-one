import 'package:tinder_linkedin/models/user.dart';
import 'package:tinder_linkedin/auth/authenticate.dart';
import 'package:tinder_linkedin/screens/root_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return RootApp();
    }

  }
}