import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/screens/info_page_og.dart';
import 'package:tinder_linkedin/screens/info_page.dart';

import 'package:tinder_linkedin/models/user.dart';
import 'package:provider/provider.dart';

class user_tile extends StatelessWidget {

  final the_user_info single_user_info;
  user_tile({ this.single_user_info });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Container(
            decoration: BoxDecoration(color:Colors.white70),
            child: ListTile(

              //leading: CircleAvatar(
               // radius: 25.0,
                //backgroundColor: Colors.brown[single_user_info.strength],
              //),
              title: Text(single_user_info.username),
              subtitle: Text(single_user_info.profession),
            ),
          ),
        ),
      ),
      onTap: () {
        print(single_user_info.id);
        Navigator.of(context).pushNamed(
            info_page.routename,
            arguments: single_user_info,
        );

    },

    );
  }
}