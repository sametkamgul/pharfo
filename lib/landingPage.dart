import 'package:flutter/material.dart';
import 'package:testapp/addCompanyPage.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> companyList = <String>[
      'Ege Üniversitesi',
      'Onmuş A.Ş.',
      '9 Eylül Üniversitesi',
      'Mate Pazarlama Teknolojileri A.Ş.',
      'Apple',
      'Samsung',
      'Sony',
      'Xiaomi',
      'Microsoft',
      'Aselsan',
      'Tesla',
      'IBM',
      'Lenovo',
      'Asus'
    ];
    // final List<int> companyPath = <int>[1, 2, 3, 4, 5, 6, 7, 8];
    double _downloadStatus = 0.25;

    return Scaffold(
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
          Expanded(
              flex: 10,
              child: new ListView.builder(
                  padding: const EdgeInsets.all(32),
                  itemCount: companyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: FlatButton(
                        color: Color(0xFF514949),
                        // height: 30,
                        onPressed: () {
                          print('clicked to the ' + companyList[index]);
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
              size: 48.0,
              color: Colors.white,
            ),
            height: 50.0,
            color: Color(0xFF514949),
            shape: CircleBorder(),
          ),

          // Upload-Progress indicator
          new Container(
            height: 16.0,
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
  }
}
