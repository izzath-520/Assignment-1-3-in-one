import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/screens/info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:tinder_linkedin/messages/image_stack.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      this.uid,
    this.message,
    this.userName,
    this.userImage,
    this.isMe,
      {
    this.key,
  });

  final uid;
  final Key key;
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {

  //   final the_users = Provider.of<List<the_user_info>>(context) ??[];                NOT WORKING!
   //  the_user_info this_user = the_users.firstWhere((element) => element.id == uid);

    return StreamProvider<List<the_user_info>>.value(
      value: DatabaseService().the_users,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                width: 140,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.title.color,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.title.color,
                      ),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: isMe ? null : 120,
            right: isMe ? 120 : null,
            child: imageStack(userImage: userImage,uid: uid,)
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
