import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './views/video_cell.dart';
import './views/video_detail.dart';

void main() => runApp(new RealWorldApp());

class RealWorldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RealWorldState();
  }
}

class RealWorldState extends State<RealWorldApp> {
  var _isLoading = true;
 
  var videos;


  _fetchData() async {
    print("Attempting to fetch data from network");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.body);

      final map = json.decode(response.body);

      final videosJson = map["videos"];

      // videosJson.forEach((video) {
      //   print(video["name"]);
      // });
      setState(() {
        this.videos = videosJson;
        _isLoading = false;
      });
    }
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _fetchData();
    }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("REAL WORLD APP BAR"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("Reloading...");
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.videos != null ? this.videos.length : 0,
                  itemBuilder: (context, i) {
                    final video = this.videos[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(0.0),
                      child: new VideoCell(video),
                      onPressed: () {
                          print("Video cell tapped: $i");
                          //open new activity
                          Navigator.push(context, 
                            new MaterialPageRoute(
                              builder: (context) => new DetailPage(video)
                            )
                          );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}




