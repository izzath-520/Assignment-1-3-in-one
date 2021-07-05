import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/screens/favourites_page.dart';
import 'package:tinder_linkedin/screens/info_page.dart';
//import 'package:tinder_linkedin/models/user info.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:tinder_linkedin/models/user.dart';
import 'package:tinder_linkedin/screens/my account body.dart';
import 'package:tinder_linkedin/models/settings_form.dart';
import 'package:tinder_linkedin/widgets/loading.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tinder_linkedin/screens/explore_page.dart';
import 'package:tinder_linkedin/models/database5.dart';


class RootApp3 extends StatefulWidget {
  @override
  _RootApp3State createState() => _RootApp3State();
}

class _RootApp3State extends State<RootApp3> {

  int pageIndex = 0;



  Future<QuerySnapshot> _users;
  TextEditingController _searchController = TextEditingController();

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null;
    });
  }

  // buildUserTile(UserModel user) {
  //   return ListTile(
  //     leading: CircleAvatar(
  //       radius: 20,
  //       backgroundImage: user.profilePicture.isEmpty
  //           ? AssetImage('assets/placeholder.png')
  //           : NetworkImage(user.profilePicture),
  //     ),
  //     title: Text(user.name),
  //     onTap: () {
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => ProfileScreen(
  //             currentUserId: widget.currentUserId,
  //             visitedUserId: user.id,
  //           )));
  //     },
  //   );
  // }




  @override
  Widget build(BuildContext context) {

 //   final UserData currentuser = Provider.of<UserData> (context);


 //   if(currentuser==null){
 //     return Loading();
 //   }
 //   else{
      return Scaffold(
        appBar: getAppBar(),
        backgroundColor: Colors.black,
        body: getBody(),
        bottomNavigationBar: getFooter(),
       // floatingActionButton: FloatingActionButton(
       //   child: Icon(Icons.add),
       //   onPressed: (){
       //     print(DateFormat('s').format(DateTime.now()));
       //   },
        //),
      );
  //  }

  }

  Widget getBody(){
    List<Widget> pages = [
      favourites_page(),
      //Center(child: Text('hello',style: TextStyle(color: Colors.white),),),
      explorePage(users: _users,),
      Center(
        child: Text("Activity Page",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),),
      ),
      my_account(),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }


  Widget getAppBar(){
    if(pageIndex == 0){
      return AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text('Favorites', style:TextStyle(color: Colors.black),),
      );
    }







    else if(pageIndex == 1){
      return AppBar(
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
        elevation: 0.5,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            hintText: 'Search Tinder_LinkedIn...',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                clearSearch();
              },
            ),
            filled: true,
          ),
          onChanged: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _users = DatabaseService5().searchUsers(input); //notice different format here, than those in
              });                                               //streambuilders and stream providers
            }
          },
        ),
      );

    }






    else if(pageIndex == 2){
      return AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text("Activity", style:TextStyle(color: Colors.black),),
      );
    }else{
      return AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text("My Account", style:TextStyle(color: Colors.black),),
        actions: <Widget>[

          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('settings'),
            onPressed: () =>
                showModalBottomSheet<dynamic>(isScrollControlled: true,context: context, builder: (context) {
                  return //Wrap(
            //        children:<Widget> [
                      Container(
                      padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 30.0),
                      child: SettingsForm(),
                    );
             //         ]
              //    );
                }),
          ),
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),

        ],
      );
    }
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0
          ? Icon(Icons.bookmark_outline, color: Colors.tealAccent)
          : Icon(Icons.bookmark_outline, color: Colors.grey.withOpacity(0.6)),
      pageIndex == 1
          ? Icon(Icons.search, color: Colors.tealAccent)
          : Icon(Icons.search, color: Colors.grey.withOpacity(0.6)),
      pageIndex == 2
          ? Icon(Icons.notifications_outlined, color: Colors.tealAccent)
          : Icon(Icons.notifications_outlined, color: Colors.grey.withOpacity(0.6)),
      pageIndex == 3
          ? Icon(Icons.person_outlined, color: Colors.tealAccent)
          : Icon(Icons.person_outlined, color: Colors.grey.withOpacity(0.6)),
    ];
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
          color: Colors.white10,
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
      pageIndex = index;
    });
  }

}
