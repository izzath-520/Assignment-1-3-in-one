import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';

class anyNewMessage extends StatefulWidget {
  @override

  String id;
  anyNewMessage({this.id});

  _anyNewMessageState createState() => _anyNewMessageState();
}

class _anyNewMessageState extends State<anyNewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';


  void _sendMessage() async {
    

    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('the-users').document(user.uid).get(); //any user page accessed
    
    Firestore.instance.collection('chats').document(widget.id).collection('messages').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],//wrong
      'userImage': userData['url']     //wrong
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {

    // final the_users = Provider.of<List<the_user_info>>(context) ??[];          NOT WORKING!
    // the_user_info this_user = the_users.firstWhere((element) => element.id == user.uid);
    // String username = this_user.username;
    // String url = this_user.url;

    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
