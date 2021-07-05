import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_linkedin/models/user.dart';

class DatabaseService4 {

  final String uid;
  DatabaseService4({this.uid});

  final CollectionReference descriptionCollection = Firestore.instance.collection('the-description');

  Future<void> updateDescription(String description) async {
    return await descriptionCollection.document(uid).setData({
      'description': description,
    });
  }


  userDescription _userDescriptionListFromSnapshot(DocumentSnapshot snapshot) {
    return userDescription(

      description: snapshot.data['description'],

      );
  }

  Stream<userDescription> get the_description { //for current user description only
    return descriptionCollection.document(uid).snapshots()
        .map(_userDescriptionListFromSnapshot);
  }

}