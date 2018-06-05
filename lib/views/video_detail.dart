import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final video;

  DetailPage(this.video);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    var videoId = video["id"];
    return new DetailState(video);
  }
}

class DetailState extends State<DetailPage> {
  final video;
  var _isLoading = true;

  var courseDetail;

  DetailState(this.video);

  _fetchData() async {
    var id = video["id"];

    print("Attempting to fetch data from network");

    final url = "https://api.letsbuildthatapp.com/youtube/course_detail?id=$id";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);

      final map = json.decode(response.body);

      map.forEach((map) {
        print(map["name"]);
        print("\n");
      });

      setState(() {
        this.courseDetail = map;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(video["name"]),
      ),
      body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount:
                      this.courseDetail != null ? this.courseDetail.length : 0,
                  itemBuilder: (context, i) {
                    final course = this.courseDetail[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(8.0),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Image.network(
                                course["imageUrl"],
                                width: 130.0,
                              ),
                              new Container(
                                width: 8.0,
                              ),
                              new Flexible(
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    new Text(course["name"],
                                        maxLines: 2,
                                        style: new TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal)),
                                    new Text(course["duration"],style: new TextStyle(
                                      fontStyle: FontStyle.italic
                                    ),),
                                    new Text("Episode #" + "${course["number"]}",
                                    style: new TextStyle(fontWeight: FontWeight.bold, 
                                    fontSize: 14.0))
                                  ],
                                ),
                                )  
                              
                            ],
                          ),

                          

                          new Divider()
                        ],
                      ),
                      onPressed: () {
                        print("cell tapped: $i");

                        final snackBar = new SnackBar(
                          content: new Text("Tab position: $i"),
                          action: new SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              print("Snack bar UNDO clicked !");
                            },
                          ),
                        );

                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    );
                  },
                )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
}
