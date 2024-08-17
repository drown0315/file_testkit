import 'dart:io';
import 'dart:async';
import 'package:file/file.dart';
import 'package:file/memory.dart';

/// A utility class that provides a method to run code within a custom file
/// system context.
///
/// This can be useful for testing, where you want to simulate file system
/// operations without affecting the real file system.
class FileTestkit {
  /// Runs the given [body] function within a custom file system context.
  ///
  /// This method returns the result of the [body] function.
  ///
  /// If a [fileSystem] is provided, it will be used as the file system context.
  /// Otherwise, a [MemoryFileSystem] is used by default, which simulates file
  /// system operations in memory.
  ///
  ///
  /// This method overrides various file system operations, such as creating files,
  /// directories, checking file system types, and more, to redirect them to the
  /// provided or default file system.
  ///
  /// Example:
  ///
  /// ```dart
  /// await FileTestkit.runZoned(() async {
  ///   final file = File('test.txt');
  ///   await file.writeAsString('Hello, world!');
  ///   print('${file.readAsStringSync()}'); // Outputs: Hello, world!
  /// });
  /// ```
  static Future<R> runZoned<R>(Function body, {FileSystem? fileSystem}) async {
    fileSystem = fileSystem ?? MemoryFileSystem();

    final result = IOOverrides.runZoned(
          () async {
        final R result = await body.call();
        return result;
      },
      createDirectory: (path) {
        return fileSystem!.directory(path);
      },
      getCurrentDirectory: () {
        return fileSystem!.currentDirectory;
      },
      setCurrentDirectory: (path) {
        fileSystem!.currentDirectory = path;
      },
      getSystemTempDirectory: () {
        return fileSystem!.systemTempDirectory;
      },
      createFile: (path) {
        return fileSystem!.file(path);
      },
      stat: (path) {
        return fileSystem!.stat(path);
      },
      statSync: (path) {
        return fileSystem!.statSync(path);
      },
      fseIdentical: (path1, path2) {
        return fileSystem!.identical(path1, path2);
      },
      fseIdenticalSync: (path1, path2) {
        return fileSystem!.identicalSync(path1, path2);
      },
      fseGetType: (path, followLinks) {
        return fileSystem!.type(path, followLinks: followLinks);
      },
      fseGetTypeSync: (path, followLinks) {
        return fileSystem!.typeSync(path, followLinks: followLinks);
      },
      createLink: (path) {
        return fileSystem!.link(path);
      },
    );
    return result;
  }
}
