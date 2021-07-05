import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/widgets/favorites_tile.dart';
import 'package:tinder_linkedin/widgets/loading.dart';


class favourites_page extends StatefulWidget {
  @override
  _favourites_pageState createState() => _favourites_pageState();
}

class _favourites_pageState extends State<favourites_page> {
  @override
  Widget build(BuildContext context) {
    final the_users = Provider.of<List<the_user_info>>(context) ??[];

    if(the_users==null){
      return Loading();
    }
    else {
      return ListView.builder(
        itemCount: the_users.length,
        itemBuilder: (context, index) {
          return user_tile(single_user_info: the_users[index]);
        },
      );
    }


  }
}
