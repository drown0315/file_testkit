import 'dart:io';

import 'package:file_testkit/file_testkit.dart';
import 'package:test/test.dart';

void main() {
  group('File Testkit', () {
    test('create file', () async {
      /// Arrange & Act.
      final String path = 'test.txt';
      final bool isCreateSuccess = await FileTestkit.runZoned(() async {
        final File file = File(path);
        file.createSync();
        return file.existsSync();
      });

      /// Assert.
      expect(isCreateSuccess, isTrue);
      expect(File(path).existsSync(), isFalse);
    });

    test('create directory', () async {
      /// Arrange & Act.
      final String path = 'mocker_test';
      final bool isCreateSuccess = await FileTestkit.runZoned(() async {
        final Directory directory = Directory(path);
        await directory.create();
        return directory.exists();
      });

      /// Assert.
      expect(isCreateSuccess, isTrue);
      expect(Directory(path).existsSync(), isFalse);
    });

    test('create link', () async {
      /// Arrange & Act.
      final String path = 'test_link';
      final bool isCreateSuccess = await FileTestkit.runZoned(() async {
        final Link link = Link(path);
        link.createSync('test.txt');
        return link.existsSync();
      });

      /// Assert.
      expect(isCreateSuccess, isTrue);
      expect(Link(path).existsSync(), isFalse);
    });
  });
}
