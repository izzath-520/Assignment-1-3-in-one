import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/database4.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/models/user.dart';
import 'package:tinder_linkedin/models/database4.dart';

class MyDescription extends StatefulWidget {
  @override
  _MyDescriptionState createState() => _MyDescriptionState();
}

class _MyDescriptionState extends State<MyDescription> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<userDescription>(
      stream: DatabaseService4(uid: user.uid).the_description,

      builder: (context,snapshot){

        if(snapshot.hasData){
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 25, right: 25, left: 25,bottom: 5),
              child: SingleChildScrollView(
                  child: Text(snapshot.data.description,
                    style: TextStyle(fontSize: 18),)),

            ),
          );
        }
        else {
          return Container();
        }
      },
    );


  }
}
