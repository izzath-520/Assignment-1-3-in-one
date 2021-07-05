import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder_linkedin/models/database3.dart';
import 'package:tinder_linkedin/models/the-user-info.dart';
import 'package:tinder_linkedin/models/user.dart';
import 'package:provider/provider.dart';
import 'package:tinder_linkedin/widgets/loading.dart';
import 'package:tinder_linkedin/models/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:tinder_linkedin/widgets/pinterest_grid.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class anyPinterestGrid extends StatefulWidget {
//  const PinterestGrid({Key key}) : super(key: key);

  @override

  String uid;
  anyPinterestGrid({this.uid});

  _anyPinterestGridState createState() => _anyPinterestGridState();
}

class _anyPinterestGridState extends State<anyPinterestGrid> {
  @override
  Widget build(BuildContext context) {

    final uid = widget.uid;

    return StreamBuilder<List<anyPost>>(
      stream: DatabaseService3(uid: uid).any_posts,
      builder: (context,snapshot){
        if(snapshot.hasData)
        {
          List<anyPost> imageList = snapshot.data;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: StaggeredGridView.countBuilder(
              //  scrollDirection: Axis.vertical,
              //  shrinkWrap: true,
                crossAxisCount: 2,
                itemCount: imageList.length,
                itemBuilder: (context, index) => GestureDetector(onTap:(){print(imageList[index].url);}, child: ImageCard(imageData: imageList[index],)),
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ),
          );
        }
        else {
          print(snapshot);
          return Container();
    }
      },


    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({this.imageData});

  final anyPost imageData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.network(imageData.url, fit: BoxFit.cover),
      );

  }
}

