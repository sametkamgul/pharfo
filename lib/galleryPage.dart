import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final String companyID;
  GalleryPage({Key key, @required this.companyID}) : super(key: key);
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
        child: Text('$companyID page'),
      ),
    );
  }
}
