import 'dart:io';
import 'package:share/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exif/exif.dart';
import 'package:geolocator/geolocator.dart';

class DisplayImagePage extends StatefulWidget {
  final String companyID;
  final File imagePath;
  final List locationInfo;

  const DisplayImagePage({
    Key key,
    @required this.companyID,
    @required this.imagePath,
    @required this.locationInfo,
  }) : super(key: key);

  @override
  _DisplayImagePageState createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  String compantID;
  File imagePath;
  List locationInfo;
  List _locationInfo = new List();

  setExifToFile(_path) async {
    // TODO: this function will set the GPS data of the image
    // gets GPS data from some other function.
  }

  // Gets the current gps location
  Future<Position> getGeolocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getExifFromFile(_path) async {
    if (_path == null) {
      return null;
    }

    var bytes = await _path.readAsBytes();
    var tags = await readExifFromBytes(bytes);
    var sb = StringBuffer();

    tags.forEach((k, v) {
      sb.write("$k: $v \n");
    });
    print(sb.toString());
    print(sb.runtimeType);
    return sb.toString();
  }

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
                // TODO: gps functions here
                print('gps-location button is clicked...');
                // getExifFromFile(widget.imagePath);
                try {
                  bool isLocationServiceEnabled =
                      await Geolocator.isLocationServiceEnabled();
                  print(isLocationServiceEnabled);
                } catch (e) {}
                try {
                  await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high)
                      .then((value) {
                    print(value.latitude);
                    print(value.longitude);
                    _locationInfo = [value.latitude, value.longitude];
                    setExifToFile(_locationInfo);
                    setState(() {});
                  });
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Image.asset('assets/images/button-location.png',
                  width: MediaQuery.of(context).size.width / 8.0),
            ),

            // TODO: GPS-location info of the image here (maybe opens in the google maps)
            new Text(
              _locationInfo.toString(),
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
                    fit: BoxFit.cover,
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
                print('share button is clicked...');

                // Sharing the image
                print(widget.locationInfo);
                Share.shareFiles([widget.imagePath.path],
                    text: widget.locationInfo.toString());
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
