import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class ConstantsParams {
  String applicatonFolderPath = '';
  getApplicationDirectory() async {
    String directory = (await getExternalStorageDirectory()).path;

    List folderList = Directory(directory)
        .listSync(recursive: true, followLinks: true)
        .toList();
    this.applicatonFolderPath = folderList.toString();
  }
}
