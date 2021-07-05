import 'package:tinder_linkedin/screens/info_page.dart';
import 'package:tinder_linkedin/screens/info_page_og.dart';
import 'package:tinder_linkedin/wrapper.dart';
import 'package:tinder_linkedin/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(  //here we provide
      value: AuthService().user,        //logged in user,
      child: MaterialApp(               //of type 'User'
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          info_page.routename:(ctx)=>info_page(),
        },

      ),
    );
  }
}