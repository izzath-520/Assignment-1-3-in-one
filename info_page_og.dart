import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/widgets/any_pinterest_grid.dart';
import 'package:tinder_linkedin/messages/new_message.dart';
import 'package:tinder_linkedin/messages/messages.dart';
import 'package:tinder_linkedin/messages/any_new_message.dart';
import 'package:tinder_linkedin/widgets/any_description.dart';
import 'package:tinder_linkedin/models/settings_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_linkedin/models/database5.dart';
import 'package:tinder_linkedin/models/user.dart';

class info_page_og extends StatefulWidget {
  @override

  the_user_info the_loadeduser;
  String currentUserId;
  info_page_og({this.currentUserId,this.the_loadeduser});

  static const routename='/user-info-page-og';
  _info_page_ogState createState() => _info_page_ogState();
}

class _info_page_ogState extends State<info_page_og> {

  int tabIndex = 0 ;
  bool _isFollowing = false;
  int _followersCount = 0;

 // var currentUserId = FirebaseAuth.instance.currentUser();



  getFollowersCount() async {
    int followersCount =
    await DatabaseService5().followersNum(widget.the_loadeduser.id);
    if (mounted) {
      setState(() {
        _followersCount = followersCount;
      });
    }
  }

  followOrUnFollow() {
    if (_isFollowing) {
      unFollowUser();
    } else {
      followUser();
    }

  }

  unFollowUser() {
    DatabaseService5().unFollowUser(widget.currentUserId, widget.the_loadeduser.id);
    setState(() {
      _isFollowing = false;
      _followersCount--;
    });
  }

  followUser() {
    DatabaseService5().followUser(widget.currentUserId, widget.the_loadeduser.id);
    setState(() {
      _isFollowing = true;
      _followersCount++;
    });
  }

  setupIsFollowing() async {
    bool isFollowingThisUser = await DatabaseService5().isFollowingUser(
        widget.currentUserId, widget.the_loadeduser.id);
    setState(() {
      _isFollowing = isFollowingThisUser;
    });
  }

  @override
  void initState() {
    super.initState();
    getFollowersCount();
  //  getFollowingCount();
    setupIsFollowing();

  }


  @override
  Widget build(BuildContext context) {
  //  final userid= ModalRoute.of(context).settings.arguments as String;
 //   final the_users = Provider.of<List<the_user_info>>(context) ??[];
   // final loadeduser = the_users.firstWhere((user) => user.id==userid);
    final loadeduser = widget.the_loadeduser;

    return Scaffold(
        backgroundColor: Colors.pink[900],
        appBar:


        AppBar(
          backgroundColor: Colors.pink[900],
          title: Text(loadeduser.username, style:TextStyle(color: Colors.white,fontSize: 25),),
          actions: <Widget>[

            InkWell(
              onTap: followOrUnFollow,
                child: _isFollowing?
                Icon(Icons.favorite,color: Colors.red,size: 40,):
                Icon(Icons.favorite_border,color: Colors.red,size: 40,)),


            Padding(
              padding: const EdgeInsets.fromLTRB(10,0,20,0),
              child: Center(child:
              Text(
                '$_followersCount Fans',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
            ),
            )

          ],
        ),








        body: Column(
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
                          backgroundImage: NetworkImage(loadeduser.url)
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
                              loadeduser.username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Text(//'hello',
                              loadeduser.profession,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                color: Colors.white,
                              ),
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
                                      loadeduser.workplace,
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
            // Padding(
            //   padding: EdgeInsets.only(left: 15, right: 10, top: 20,bottom: 20),
            //   child: Container(
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               '30k',
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 25),
            //             ),
            //             Text(
            //               'votes',
            //               style: TextStyle(
            //                   color: Colors.white),
            //             )
            //           ],
            //         ),
            //         Container(
            //           color: Colors.white,
            //           width: 0.2,
            //           height: 22,
            //         ),
            //   //      InkWell(
            //    //       child:
            //         Container(
            //             padding: EdgeInsets.only(
            //                 left: 20, right: 20, top: 9, bottom: 9),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(1)),
            //      //         gradient: LinearGradient(
            //      //             colors: loadeduser.isfavorite ? [Colors.black54,Colors.grey]:[Colors.tealAccent, Colors.pinkAccent],
            //      //             begin: Alignment.bottomLeft,
            //      //             end: Alignment.centerRight
            //      //         ),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.black,
            //                   offset: Offset(4.0, 2.0), //(x,y)
            //                   blurRadius: 10.0,
            //                 ),
            //               ],
            //             ),
            //             child: Text('hello',//loadeduser.isfavorite ? 'Voted' : 'Vote',
            //      //         style: TextStyle(
            //       //            color: loadeduser.isfavorite ? Colors.white:Colors.black87,
            //      //             fontWeight: FontWeight.bold
            //       //        ),),
            //           ),
            //       //    onTap: () {
            //       //      loadeduser.togglefavoritestatus();
            //      //     },
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            getTab(),

            Expanded(child: getContent(loadeduser.id)),

          ],
        )

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
                    child: Text(
                      'Portfolio',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 33),
                    ),
                  ),
                  anyPinterestGrid(uid: uid),
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
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 33),
                    ),
                  ),
                  AnyDescription(uid: uid),
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
                        anyNewMessage(id: uid,),
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
