import 'package:tinder_linkedin/models/user.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:tinder_linkedin/widgets/constants.dart';
import 'package:tinder_linkedin/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentusername;
  String _currentprofession;
  String _currentworkplace;

  String _pickedImage;

  void _pickImage(uid) async {
    final pickedImageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image');
       // .child(uid + '.jpg');

    await ref.putFile(pickedImageFile).onComplete;
    final url = await ref.getDownloadURL();

    setState(() {
      _pickedImage = url;
    });
 //   widget.imagePickFn(pickedImageFile);
  }


  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[


                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        _pickedImage==null? NetworkImage(userData.url) : NetworkImage(_pickedImage),
                    //_pickedImage != null ? FileImage(_pickedImage) : null,
                  ),
                  FlatButton.icon(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: (){
                      _pickImage(userData.uid);
                    },
                    icon: Icon(Icons.image),
                    label: Text('Change Image'),
                  ),


                  Text(
                    'Update your user settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.username,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentusername = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.profession,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a Profession' : null,
                    onChanged: (val) => setState(() => _currentprofession = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.workplace,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a workplace' : null,
                    onChanged: (val) => setState(() => _currentworkplace = val),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateSettings(
                              _pickedImage?? snapshot.data.url,
                              _currentusername?? snapshot.data.username,
                              _currentprofession ?? snapshot.data.profession,
                              _currentworkplace ?? snapshot.data.workplace
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}