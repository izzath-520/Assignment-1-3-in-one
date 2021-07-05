import 'package:flutter/cupertino.dart';
import 'package:tinder_linkedin/models/user.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:tinder_linkedin/widgets/constants.dart';
import 'package:tinder_linkedin/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tinder_linkedin/models/database4.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DescriptionForm extends StatefulWidget {
  @override
  _DescriptionFormState createState() => _DescriptionFormState();
}

class _DescriptionFormState extends State<DescriptionForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentdescription;
 // String _currentprofession;
 // String _currentworkplace;

  // String _pickedImage;
  //
  // void _pickImage(uid) async {
  //   final pickedImageFile = await ImagePicker.pickImage(
  //     source: ImageSource.camera,
  //     imageQuality: 50,
  //     maxWidth: 150,
  //   );
  //
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('user_image');
  //   // .child(uid + '.jpg');
  //
  //   await ref.putFile(pickedImageFile).onComplete;
  //   final url = await ref.getDownloadURL();
  //
  //   setState(() {
  //     _pickedImage = url;
  //   });
  //   //   widget.imagePickFn(pickedImageFile);
  // }


  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    final maxLines = 5;

    return StreamBuilder<userDescription>(
            stream: DatabaseService4(uid: user.uid)
                .the_description,

            builder: (context, snapshot) {


              if(snapshot.hasData) {
             //   print(snapshot.data);
                userDescription user_description = snapshot.data;

                return Form(
                  key: _formKey,
                  child: Column(children: <Widget>[

                    Text(
                      'Description',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 33),
                    ),

                    SizedBox(height: 20.0),

                    Container(
                      margin: EdgeInsets.all(12),
                      height: maxLines * 24.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                      ),
                      child: TextFormField(
                        maxLines: maxLines,
                        initialValue: user_description.description,
                        decoration: textInputDecoration,
                        validator: (val) =>
                        val.isEmpty
                            ? 'Please enter a name'
                            : null,
                        onChanged: (val) =>
                            setState(() => _currentdescription = val),
                      ),
                    ),


                    SizedBox(height: 10.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService4(uid: user.uid)
                                .updateDescription(
                              _currentdescription ?? snapshot.data.description,

                            );
                            Navigator.pop(context);
                          }
                        }
                    ),
                  ],
                  ),
                );


              }

              return Loading();
            }
            );

  }
}