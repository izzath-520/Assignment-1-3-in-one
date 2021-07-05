import 'package:tinder_linkedin/auth/auth.dart';
import 'package:tinder_linkedin/widgets/constants.dart';
import 'package:tinder_linkedin/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/widgets/user_image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String username ='';
  String profession = '';
  String workplace = '';
  String password = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        elevation: 0.0,
        title: Text('Sign up to Tinder Linkedin'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Builder(
        builder: (context) =>
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    UserImagePicker(_pickedImage),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'username'),
                      validator: (val) => val.isEmpty ? 'Enter a username' : null,
                      onChanged: (val) {
                        setState(() => username = val);
                      },
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'profession'),
                      validator: (val) => val.isEmpty ? 'Enter a profession' : null,
                      onChanged: (val) {
                        setState(() => profession = val);
                      },
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'workplace'),
                      validator: (val) => val.isEmpty ? 'Enter a workplace' : null,
                      onChanged: (val) {
                        setState(() => workplace = val);
                      },
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'password'),
                      obscureText: true,
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.blueGrey,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {

                        if (_userImageFile == null ) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please pick an image.'),
                              backgroundColor: Theme.of(context).errorColor,
                            ),
                          );
                          return;
                        }

                        if(_formKey.currentState.validate())
                        {
                          setState(() => loading = true);

                          dynamic result = await _auth.registerWithEmailAndPassword(_userImageFile,email,username,profession,workplace, password);
                          if(result == null) {
                            setState(() {
                              loading = false;
                              error = 'Sorry da, something went wrong';
                            });
                          }
                        }
                      }
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }
}