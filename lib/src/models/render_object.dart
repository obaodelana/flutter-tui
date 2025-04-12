import 'package:flutter_tui/src/models/size.dart';

class RenderObject {
  final Size rect;
  final String text;

  const RenderObject({required this.rect, required this.text});

  @override
  bool operator==(covariant RenderObject other) {
    return rect == other.rect && text == other.text;
  }
  
  @override
  int get hashCode => Object.hash(rect, text);
}
