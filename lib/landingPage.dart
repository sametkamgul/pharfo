import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pharfo/addCompanyPage.dart';
import 'package:pharfo/galleryPage.dart';

import 'package:path/path.dart' show join;

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

// Data transfer class for folder-company info
class CompanyData {
  final String companyID;
  CompanyData(this.companyID);
}

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  String directory;
  double _downloadStatus = 0.25;
  List folderList = new List();
  List companyList = new List();
  String applicationDirectory = '';

  void initState() {
    super.initState();
  }

  _listFoldersRefresh() async {
    // refresh page
    // companyList.clear();
    // print('ref p here...');

    directory = join((await getExternalStorageDirectory()).path, 'Media');
    applicationDirectory = directory;
    try {
      folderList = Directory(directory)
          .listSync(recursive: true, followLinks: true)
          .toList();
    } catch (e) {
      // print('error');
    }

    for (int x = 0; x < folderList.length; x++) {
      if (folderList.length > 1 && folderList[x] is Directory) {
        // there is a sub-folder
        // applicationDirectory = folderList[x].path;
        // print('dir:' + applicationDirectory);
        // print(x.toString() + folderList[x].toString());
        var _t = (folderList[x].path).split(applicationDirectory).toString();
        // print(x.toString() + _t);
        _t = _t.substring(4, _t.length - 1);
        companyList.add(_t);
        // print(companyList.toString());
        companyList = companyList.toSet().toList();
      } else {
        // null
      }
    }
    // FIXME: refreshing the page here
    setState(() {});
  }

  _getApplicationDirectory() async {
    String _dir = (await getExternalStorageDirectory()).path;
  }

  _createMediaDirectory() async {
    // INFO: creating folder if not exists. this will move!!!
    final myDir = new Directory(
        join((await getExternalStorageDirectory()).path, 'Media'));
    myDir.exists().then((isThere) {
      if (isThere) {
        print('exists: ' + myDir.path);
      } else {
        print('non-existent. Directory is creating...');
        myDir.create(recursive: true).then((directory) {
          print('path:' + directory.path);
        });
      }
    });
  }

  // _createDirectories() async {
  //   // INFO: creating folder if not exists. this will move!!!
  //   final myDir = new Directory(join(
  //       (await getExternalStorageDirectory()).path, 'Media', companyList[0]));
  //   myDir.exists().then((isThere) {
  //     if (isThere) {
  //       print('exists: ' + myDir.path);
  //     } else {
  //       print('non-existent. Directory is creating...');
  //       myDir.create(recursive: true).then((directory) {
  //         print('path:' + directory.path);
  //       });
  //     }
  //   });
  // }

  dynamic _listofFiles() async {
    directory = (await getExternalStorageDirectory()).path;

    folderList = Directory(directory)
        .listSync(recursive: true, followLinks: true)
        .toList();
    for (int x = 0; x < folderList.length; x++) {
      if (folderList[x] is Directory && folderList[x] == folderList[0]) {
        // print(x.toString() + ' ' + folderList[x].toString());
      } else {
        // print(x.toString() + ' ' + folderList[x].toString());
      }
    }

    // FIXME: refreshing the page here
    setState(() {});
    return folderList;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    try {
      _getApplicationDirectory();
    } on FileSystemException {
      print('Media directory is not found');
      _createMediaDirectory();
    } catch (e) {
      print(e.toString());
    }

    try {
      _listofFiles();
    } on FileSystemException {
      print('there are no directory to list');
      throw Exception('testing....');
    } catch (e) {
      print(e.toString());
    }

    try {
      _listFoldersRefresh();
    } on FileSystemException {
      print('there are no directory to refresh view');
    } catch (e) {
      print(e.toString());
    }

    // print(folderList);
    // print(folderList.length);
    var scaffold = Scaffold(
      backgroundColor: Color(0xFFFFDFCD),
      body: Column(
        children: [
          new Padding(
            padding: EdgeInsets.all(20),
          ),
          new Expanded(
              child: Text(
            'Company List',
            style: TextStyle(fontSize: 36.0),
          )),
          new Padding(
            padding: EdgeInsets.all(10),
          ),

          // ListView-List of Companies
          Expanded(
              flex: 10,
              child: new ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: companyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: FlatButton(
                        color: Color(0xFF514949),
                        // height: 30,
                        onPressed: () {
                          print('clicked to the ' + companyList[index]);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  GalleryPage(companyID: companyList[index])));
                        },
                        child: Text(
                          companyList[index].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xFF514949),
                                width: 0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  })),
          Padding(padding: EdgeInsets.all(8.0)),

          // Add-New Company Button
          new FlatButton(
            onPressed: () {
              print('clicked to the ADD button');
              // Redirect to the Company Textfield page
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: true, // set to false
                  pageBuilder: (_, __, ___) => AddCompanyPage(),
                ),
              );
            },
            child: new Icon(
              Icons.add,
              size: 60.0,
              color: Colors.white,
            ),
            height: 60.0,
            color: Color(0xFF514949),
            shape: CircleBorder(),
          ),

          Padding(padding: EdgeInsets.all(8.0)),

          // Upload-Progress indicator
          new Container(
            height: 8.0,
            child: LinearProgressIndicator(
              backgroundColor: Color(0xFF514949),
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFC7E7E)),
              semanticsLabel: 'uploading',
              value: _downloadStatus,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
    return scaffold;
  }
}
