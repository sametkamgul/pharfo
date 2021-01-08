import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AddCompanyPage extends StatelessWidget {
  final myController = TextEditingController();

  _createDirectories(dirName) async {
    // INFO: creating folder if not exists. this will move!!!
    final myDir = new Directory(
        join((await getExternalStorageDirectory()).path, 'Media', dirName));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFDFCD),
      body: Center(
          child: Column(
        children: [
          // TextField-AddNewCompany
          new Container(
            child: TextField(
              cursorColor: Color(0xFF514949),
              style: TextStyle(fontSize: 32.0),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: 'please enter a company', border: InputBorder.none),
              controller: myController,
            ),
          ),
          Row(
            children: [
              //
              Padding(
                padding: EdgeInsets.all(10.0),
              ),

              // Add-Button
              Expanded(
                child: FlatButton(
                  height: 64.0,
                  color: Color(0xFF514949),
                  onPressed: () {
                    print('clicked to the add-sub button');
                    print('<' +
                        myController.text +
                        '> folder is creating now...');
                    _createDirectories(myController.text);
                    Navigator.of(context).pop(); //popping the screen
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 32.0, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color(0xFF514949),
                          width: 0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              // Cancel-Button
              Expanded(
                child: FlatButton(
                  height: 64.0,
                  color: Color(0xFF514949),
                  // height: 30,
                  onPressed: () {
                    print('clicked to the cancel button');
                    // Redirect to the previous page
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'cancel',
                    style: TextStyle(fontSize: 32.0, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color(0xFF514949),
                          width: 0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Padding(padding: EdgeInsets.all(32.0)),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
      )),
    );
  }
}
