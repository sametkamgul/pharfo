import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'testcamera.dart';
import 'dart:io';

Future<void> main() async {
  runApp(
    MaterialApp(
        theme: ThemeData.dark(),
        home: GalleryPage(
          // Pass the appropriate camera to the TakePictureScreen widget.
          companyID: 'firstCamera',
        )),
  );
}

class GalleryPage extends StatefulWidget {
  final String companyID;

  const GalleryPage({
    Key key,
    @required this.companyID,
  }) : super(key: key);

  @override
  GalleryPageState createState() => GalleryPageState();
}

class GalleryPageState extends State<GalleryPage> {
  String directory = '';
  String companyID = '';
  List fileList = [];
  CameraDescription firstCamera;
  double _downloadStatus = 0.25;

  void initState() {
    super.initState();
  }

  // _loadLocalImage(String _companyName) async {
  //   print('$_companyName gallery is started...');
  //   Image.file(
  //       File(join((await getExternalStorageDirectory()).path, _companyName)));
  // }

  dynamic _listofFiles() async {
    directory = (await getExternalStorageDirectory()).path;

    fileList = Directory("$directory/Media/" + widget.companyID)
        .listSync(); //use your folder name insted of resume.

    // FIXME: refreshing the page here
    setState(() {});
    return fileList;
  }

  @override
  Widget build(BuildContext context) {
    // Read a jpeg image from file.
    // _loadLocalImage(companyID);
    // try {
    //   _listofFiles();
    // } catch (e) {
    //   print('HATA: ' + e);
    // }

    _listofFiles();
    // print(fileList[0]);

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
              widget.companyID,
              style: TextStyle(fontSize: 36.0),
            )),
            new Padding(
              padding: EdgeInsets.all(10),
            ),

            // Gallery Section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                height: 200,
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 3,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(fileList.length, (index) {
                    return Container(
                      child: Image.file(
                        fileList[index],
                        // new File(
                        //     '/storage/emulated/0/Android/data/com.example.pharfo/files/Media/Ege Üniversitesi/2021-01-03 03:30:23.235422.png'),
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF514949),
                          border: Border.all(
                              color: Color(0xFF514949),
                              width: 5.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20.0)),
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
                        companyName: widget.companyID,
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
