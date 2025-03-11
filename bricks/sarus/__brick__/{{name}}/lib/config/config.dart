import 'dart:io';

class Config {
  static final Directory baseDir =
      File(Platform.script.toFilePath()).parent.parent;
}
