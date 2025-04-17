import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/writer_object.dart';
import 'package:uuid/uuid.dart';

abstract class Widget {
  late final String key;
  WriterObject build(Size constraint);

  Widget({String? key}) {
    this.key = key ?? Uuid().v1();
  }
}
