# file_testkit

A simple way to mock file-related operations in Dart, ideal for testing. It can simulate any file-related operation in a memory-based file system, preventing changes to your actual file system.


## Why Use file_testkit?

- **Isolated Testing Environments**: Each test runs in its own file system environment, preventing interference between tests.
- **Safe Testing**: Mock file operations in memory without affecting the real file system.
- **Simple Setup**: Quickly integrate with just a few lines of code.
- **Ideal for Unit Tests**: Ensure your file-related logic works correctly in isolation.


## Usage

### 1. add dependencies into you project pubspec.yaml file

```yaml
dependencies:
  file_testkit: ^1.0.0
```
Run `flutter packages get` in the root directory of your app.

### 2. import file_testkit lib
```dart
import 'package:file_testkit/file_testkit.dart';
```

### 3. use file_testkit
```dart
await FileTestkit.runZoned(() async {
  final File file = File('test.txt');

  file.createSync();
  file.writeAsStringSync('hello');

  print('test.txt existed is ${file.existsSync()}');
  if (file.existsSync()) {
    print('file content: ${file.readAsStringSync()}');
  }
});
```