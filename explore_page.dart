import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/messages/image_stack.dart';
import 'package:tinder_linkedin/models/database2.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/models/user.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/widgets/loading.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:tinder_linkedin/widgets/pinterest_grid.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tinder_linkedin/screens/info_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class explorePage extends StatefulWidget {
  @override



  Future<QuerySnapshot> users;
  explorePage({this.users});




  _explorePageState createState() => _explorePageState();
}

class _explorePageState extends State<explorePage> {
  @override


  buildUserTile(the_user_info user) {
    return Card(
      margin: EdgeInsets.fromLTRB(6.0, 10.0, 6.0, 0.0),
      child: Container(
        decoration: BoxDecoration(color:Colors.white),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user.url),
          ),
          title: Text(user.username, style: TextStyle(color: Colors.black),),
          subtitle: Text(user.profession, style: TextStyle(color: Colors.black),),
          onTap: () {
            Navigator.of(context).pushNamed(
              info_page.routename,
              arguments: user,
            );
          },
        ),
      ),
    );
  }



  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
}

  Widget build(BuildContext context) {

    final the_users = Provider.of<List<the_user_info>>(context) ??[];


    return widget.users == null ? StreamBuilder<List<explorePost>>(
      stream: DatabaseService().explore_posts,
      builder: (context,snapshot){
        if(snapshot.hasData)
        {
          List<explorePost> imageList = snapshot.data;
          imageList.shuffle();
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: RefreshIndicator(
                    onRefresh: refreshList,
                    child: StaggeredGridView.countBuilder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: imageList.length,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap:(){
                            the_user_info explore_user = the_users.firstWhere((element) => element.id == imageList[index].uid);
                            //print(explore_user.password);
                            Navigator.of(context).pushNamed(
                                info_page.routename,
                                arguments: explore_user);
                            },
                          child: ImageCard(imageData: imageList[index],)),
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        else {
          print(snapshot);
          return Container();
        }
      },


    ): FutureBuilder(
        future: widget.users,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text('No users found!',style: TextStyle(color: Colors.white),),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                the_user_info user =
                the_user_info.fromDoc(snapshot.data.documents[index]);
                return buildUserTile(user);
              });
        });

  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({this.imageData});

  final explorePost imageData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child:Image.network(imageData.url, fit: BoxFit.cover),
    );
  }
}