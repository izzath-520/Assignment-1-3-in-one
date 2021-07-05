import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/database2.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/models/user.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/widgets/loading.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:tinder_linkedin/widgets/pinterest_grid.dart';
import 'package:tinder_linkedin/messages/new_message.dart';
import 'package:tinder_linkedin/messages/messages.dart';
import 'package:tinder_linkedin/models/settings_form.dart';
import 'package:tinder_linkedin/models/description_form.dart';
import 'package:tinder_linkedin/widgets/my_description.dart';

class my_account extends StatefulWidget {
  @override
  _my_accountState createState() => _my_accountState();
}

class _my_accountState extends State<my_account> {

  int tabIndex = 0;





  String _pickedImage;


  void _pickImage(uid) async {

    String postId = Uuid().v1();

    final pickedImageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    final ref = FirebaseStorage.instance
        .ref()
        .child('post_images')
        .child(uid)
        .child(postId + '.jpg');

    await ref.putFile(pickedImageFile).onComplete;
    final url = await ref.getDownloadURL();

    await DatabaseService2(uid: uid, postId: postId).updatePost(url);
    await DatabaseService(uid: uid).updateExplorePost(url);

    setState(() {
      _pickedImage = url;
    });
    //   widget.imagePickFn(pickedImageFile);
  }







  @override
  Widget build(BuildContext context) {


    User user = Provider.of<User>(context);

      return  StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if(snapshot.hasData){
            UserData currentuser = snapshot.data;
            return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: CircleAvatar(
                          radius: 38,
                          backgroundImage: NetworkImage(currentuser.url)
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 38.0, top: 12),
                      child:
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(//'hello',
                              currentuser.username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Text(//'hello',
                              currentuser.profession,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                color: Colors.white,),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white70,
                                    size: 18,
                                  ),

                                  Expanded(
                                    child: Text(//'hello',
                                      currentuser.workplace,
                                      style: TextStyle(
                                          color: Colors.white,
                                          wordSpacing: 2,
                                          letterSpacing: 4
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //   Padding(
            //     padding: EdgeInsets.only(left: 15, right: 10, top: 20, bottom: 20),
            //     child: Container(
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text('30k',
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 25),
            //               ),
            //               Text(
            //                 'votes',
            //                 style: TextStyle(
            //                     color: Colors.white),
            //               )
            //             ],
            //           ),
            //
            //           Container(
            //             color: Colors.white,
            //             width: 0.2,
            //             height: 22,
            //           ),
            //
            //
            //        Container(
            //          padding: EdgeInsets.only(
            //              left: 20, right: 20, top: 9, bottom: 9),
            //          decoration: BoxDecoration(
            //            borderRadius: BorderRadius.all(Radius.circular(1)),
            // //         gradient: LinearGradient(
            // //             colors: loadeduser.isfavorite ? [Colors.black54,Colors.grey]:[Colors.tealAccent, Colors.pinkAccent],
            // //             begin: Alignment.bottomLeft,
            // //             end: Alignment.centerRight
            // //         ),
            //            boxShadow: [
            //              BoxShadow(
            //                color: Colors.deepOrangeAccent,
            //                offset: Offset(4.0, 2.0),
            //              ),
            //            ],
            //          ),
            //          child: Text(
            //            'hello',
            //            style: TextStyle(color: Colors.white),
            //          ),
            //        )
            //
            //         ],
            //       ),
            //     ),
            //   ),

              getTab(),

              Expanded(child: getContent(currentuser.uid)),

            ],
            );
            }

            else {
              return Loading();
            }

          }
          );

  }


  Widget getTab() {
    List bottomItems = [
      tabIndex == 0
          ? Icon(Icons.photo_album_outlined, color: Colors.tealAccent)
          : Icon(Icons.photo_album_outlined, color: Colors.grey.withOpacity(0.6)),
      tabIndex == 1
          ? Icon(Icons.description_outlined, color: Colors.tealAccent)
          : Icon(Icons.description_outlined, color: Colors.grey.withOpacity(0.6)),
      tabIndex == 2
          ? Icon(Icons.comment_outlined, color: Colors.tealAccent)
          : Icon(Icons.comment_outlined, color: Colors.grey.withOpacity(0.6)),
    ];

    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.vertical(top: Radius.circular(33))
      ),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return InkWell(
              onTap: () {
                selectedTab(index);
              },
              child: bottomItems[index],
            );
          }),
        ),
      ),
    );
  }
  selectedTab(index) {
    setState(() {
      tabIndex = index;
    });
  }

  Widget getContent(String uid){
    List<Widget> tabs = [
      Container(
          width: double.infinity,
          //  margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.vertical(
            //  top: Radius.circular(34)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 25, right: 25, left: 25),
                child: Row(
                  children: [
                    Text(
                      'Portfolio',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 33),
                    ),

                    SizedBox(width: 10,),

                    InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey,
                          ),
                          child: Padding(
                            child: Text('+', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),),
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10) ,
                          ),
                        ),
                      onTap: (){
                          _pickImage(uid);
                      },

                    )
                  ],
                ),
              ),

              PinterestGrid(uid:uid),

            ],
          )
      ),

      Container(
          width: double.infinity,
          //   margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.vertical(
            //    top: Radius.circular(34)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 25, right: 25, left: 25),
                child: Row(
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 33),
                    ),
                    SizedBox(width: 10,),

                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                        child: Padding(
                          child: Icon(Icons.edit),
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10) ,
                        ),
                      ),
                      onTap: () =>
                          showModalBottomSheet<dynamic>(isScrollControlled: true,context: context, builder: (context) {
                            return //Wrap(
                              //        children:<Widget> [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 30.0),
                                child: DescriptionForm(),
                              );
                            //         ]
                            //    );
                          }),

                    )
                  ],
                ),
              ),
              MyDescription(),
            ],
          )
      ),

      Container(
          width: double.infinity,
          //  margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.vertical(
            //   top: Radius.circular(34)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 25, right: 25, left: 25),
                child: Text(
                  'Comments',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 33),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Messages(id: uid,),//Messages(),
                    ),
                    NewMessage(),
                  ],
                ),
              ),
            ],
          )
      )


    ];
    return IndexedStack(
      index: tabIndex,
      children: tabs,
    );
  }


}

