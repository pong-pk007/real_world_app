import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoCell extends StatelessWidget {
  final video;

//constructure
  VideoCell(this.video);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Display data from json videos
              // new Center(child: new CircularProgressIndicator()),
              new Center(
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: video["imageUrl"],
                ),
              ),
              new Container(
                height: 8.0,
              ),

              new ListTile(
                title: new Text(
                  video["name"],
                  style: new TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,),
                leading: new CircleAvatar(
                  backgroundColor: Colors.red,
                  backgroundImage: new NetworkImage(video["imageUrl"]),
                ),
              ),
            ],
          ),
        ),
        new Divider()
      ],
    );
  }
}
