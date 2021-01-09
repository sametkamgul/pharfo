import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayImagePage extends StatefulWidget {
  final String companyID;
  final File imagePath;
  const DisplayImagePage({
    Key key,
    @required this.companyID,
    @required this.imagePath,
  }) : super(key: key);

  @override
  _DisplayImagePageState createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  String compantID;
  File imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Row(children: [
            // Navigation Back Button
            IconButton(
              iconSize: 48.0,
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                print('back button is pressed!!!');
                Navigator.of(context).pop();
              },
            )
          ], mainAxisAlignment: MainAxisAlignment.start)),
      backgroundColor: Color(0xFFFFDFCD),
      body: new Center(
        child: new Column(
          children: [
            new Padding(
              padding: EdgeInsets.all(20),
            ),

            // header
            new Text(
              widget.companyID,
              style: TextStyle(fontSize: 36.0),
            ),

            new Padding(
              padding: EdgeInsets.all(20),
            ),

            // GPS-location button
            FlatButton(
              onPressed: () async {
                // TODO: share functions here
              },
              child: Image.asset('assets/images/button-location.png',
                  width: MediaQuery.of(context).size.width / 8.0),
            ),
            // TODO: GPS-location info of the image here (maybe opens in the google maps)
            new Text(
              'location',
              style: TextStyle(fontSize: 12.0),
            ),

            new Padding(
              padding: EdgeInsets.all(20),
            ),

            Expanded(
              child: new Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.file(
                    widget.imagePath,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(8.0)),

            // share button
            FlatButton(
              onPressed: () async {
                // TODO: share functions here
              },
              child: Image.asset('assets/images/button-export.png',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width / 8.0),
            ),

            Padding(padding: EdgeInsets.all(8.0)),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
