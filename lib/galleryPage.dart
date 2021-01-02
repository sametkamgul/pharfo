import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'testcamera.dart';

class GalleryPage extends StatelessWidget {
  final String companyID;
  CameraDescription firstCamera;
  GalleryPage({Key key, @required this.companyID}) : super(key: key);
  double _downloadStatus = 0.25;

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
            // Page Header

            new Padding(
              padding: EdgeInsets.all(20),
            ),
            new Expanded(
                child: Text(
              '$companyID',
              style: TextStyle(fontSize: 36.0),
            )),
            new Padding(
              padding: EdgeInsets.all(10),
            ),

            // Gallery Section

            // Take Photo Button
            FlatButton(
              onPressed: () async {
                print('photo capture button clicked!!!');

                //  getting the camera descriptions

                final cameras = await availableCameras();
                this.firstCamera = cameras[0];
                print(this.firstCamera);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TakePictureScreen(
                        camera: cameras[1],
                        companyName: companyID,
                      ),
                    ));
              },
              child: Image.asset('assets/images/button-camera.png',
                  width: MediaQuery.of(context).size.width / 3.0),
            ),

            Padding(padding: EdgeInsets.all(8.0)),

            // Upload-Progress indicator
            new Container(
              height: 8.0,
              child: LinearProgressIndicator(
                backgroundColor: Color(0xFF514949),
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xFFFC7E7E)),
                semanticsLabel: 'uploading',
                value: _downloadStatus,
              ),
            )
          ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center)),
    );
  }
}
