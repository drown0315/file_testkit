# file_testkit

一种非常简单方式在Dart中模拟文件相关的操作。它可以在基于Memory的文件系统中模拟任何文件相关的操作，防止对实际文件系统的更改。

## 为什么使用 file_testkit？

- **隔离测试环境**：每个测试在其独立的文件系统环境中运行，避免测试之间的相互干扰。
- **安全测试**：在Memory中模拟文件操作，而不影响实际的文件系统。

## 使用方法

### 1. 在项目的 pubspec.yaml 文件中添加依赖项

```yaml
dependencies:
  file_testkit: ^1.0.0
```

在应用程序的根目录下运行 `flutter packages get`。

### 2. 导入 file_testkit 库

```dart
import 'package:file_testkit/file_testkit.dart';
```

### 3. 使用 file_testkit

```dart
await FileTestkit.runZoned(() async {
  final File file = File('test.txt');

  file.createSync();
  file.writeAsStringSync('hello');

  print('test.txt 是否存在: ${file.existsSync()}');
  if (file.existsSync()) {
    print('文件内容: ${file.readAsStringSync()}'); // output: hello
  }
});
```