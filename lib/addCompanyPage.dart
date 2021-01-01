import 'package:flutter/material.dart';

class AddCompanyPage extends StatelessWidget {
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
