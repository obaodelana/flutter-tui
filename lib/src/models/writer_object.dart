import 'package:flutter_tui/src/models/size.dart';

class WriterObject {
  final String widgetKey;
  final Size size;
  final String text;
  final List<WriterObject>? _children;
  WriterObject? _parent;

  WriterObject? get parent => _parent;
  // Only set if parent is not already set
  set parent (WriterObject? value) => _parent ??= value;

  bool get hasChildren => _children?.isNotEmpty ?? false;
  int get childrenCount => _children?.length ?? 0;
  WriterObject? get firstChild => _children?.firstOrNull;
  WriterObject? get lastChild => _children?.lastOrNull;

  WriterObject getChild(int i) {
    assert(_children != null, "I don't have children!");
    if (i < 0 || i >= childrenCount) {
      throw IndexError.withLength(i, childrenCount);
    }

    return _children![i];
  }

  WriterObject({
      required this.widgetKey,
      required this.size,
      required this.text,
      List<WriterObject>? children
    }) : _children = children {
      if (children != null) {
        // Set parent of children
        for (WriterObject child in children) {
          child.parent = this;
        }
      }
    }

  @override
  bool operator==(covariant WriterObject other) {
    if (size != other.size
        || text != other.text
        || widgetKey != other.widgetKey) {
      return false;
    } else if (_children == null && other._children == null) {
      return true;
    } else if (childrenCount != other.childrenCount) {
      return false;
    } else {
      for (int i = 0; i < childrenCount; i++) {
        if (getChild(i) != other.getChild(i)) {
          return false;
        }
      }
    }

    return true;
  }
  
  @override
  int get hashCode => widgetKey.hashCode;
}
