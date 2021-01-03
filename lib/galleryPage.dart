import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'testcamera.dart';
import 'package:path/path.dart' show join;
import 'dart:io';

class GalleryPage extends StatelessWidget {
  final String companyID;
  String directory;
  List fileList = [];
  CameraDescription firstCamera;
  GalleryPage({Key key, @required this.companyID}) : super(key: key);
  double _downloadStatus = 0.25;

  _loadLocalImage(String _companyName) async {
    print('$_companyName gallery is started...');
    Image.file(
        File(join((await getExternalStorageDirectory()).path, companyID)));
  }

  dynamic _listofFiles() async {
    directory = (await getExternalStorageDirectory()).path;

    fileList = Directory("$directory/Media/$companyID/")
        .listSync(); //use your folder name insted of resume.
    // print(fileList);
    // print(fileList.length);
    return fileList;
  }

  int _getFileListLength() {
    print(fileList.length);
    return 5;
  }

  @override
  Widget build(BuildContext context) {
    // Read a jpeg image from file.
    // _loadLocalImage(companyID);
    try {
      _listofFiles();
    } catch (e) {
      print('HATA: ' + e);
    }

    print('TEST' + fileList.toString());
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
            new Container(
                child: Text(
              '$companyID',
              style: TextStyle(fontSize: 36.0),
            )),
            new Padding(
              padding: EdgeInsets.all(10),
            ),

            // Gallery Section
            Expanded(
              child: Container(
                height: 200,
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 3,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(_getFileListLength(), (index) {
                    return Container(
                      child: Image.file(
                        new File(
                            '/storage/emulated/0/Android/data/com.example.pharfo/files/Media/Ege Üniversitesi/2021-01-03 03:30:23.235422.png'),
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    );
                  }),
                ),
              ),
            ),

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center)),
    );
  }
}
