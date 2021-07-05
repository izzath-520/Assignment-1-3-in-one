import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/screens/info_page_og.dart';
import 'package:tinder_linkedin/models/user.dart';

class info_page extends StatelessWidget {

  static const routename='/user-info-page';

  @override
  Widget build(BuildContext context) {
   // final userid= ModalRoute.of(context).settings.arguments as String;
   // final _loadeduser= Provider.of<user_list>(context)
   //     .findById(userid);
    final user= ModalRoute.of(context).settings.arguments as the_user_info;

    final my_user = Provider.of<User>(context);

    return info_page_og(currentUserId: my_user.uid,the_loadeduser: user,);

  }
}
