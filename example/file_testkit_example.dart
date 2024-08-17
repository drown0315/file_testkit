import 'dart:io';

import 'package:file_testkit/file_testkit.dart';

void main() async {
  await FileTestkit.runZoned(() async {
    final File file = File('test.txt');

    file.createSync();
    file.writeAsStringSync('hello');

    print('test.txt existed is ${file.existsSync()}');
    if (file.existsSync()) {
      print('file content: ${file.readAsStringSync()}');
    }
  });
}
