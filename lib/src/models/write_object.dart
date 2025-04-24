import 'package:flutter_tui/src/models/size.dart';

class WriteObject {
  Size size;
  final String? text;
  final List<WriteObject>? _children;
  WriteObject? _parent;

  bool get hasText => text != null;

  WriteObject? get parent => _parent;
  // Only set if parent is not already set
  set parent(WriteObject? value) => _parent ??= value;

  int get childCount => _children?.length ?? 0;
  bool get hasChildren => childCount > 0;
  WriteObject? get firstChild => _children?.firstOrNull;
  WriteObject? get lastChild => _children?.lastOrNull;

  WriteObject({
    required this.size,
    this.text,
    List<WriteObject>? children
  }) : _children = children {
    if (children != null) {
      // Set parent of children
      for (WriteObject child in children) {
        child.parent = this;
      }
    }
  }

  WriteObject getChild(int i) {
    assert(_children != null, "I don't have children!");
    if (i < 0 || i >= childCount) {
      throw IndexError.withLength(i, childCount);
    }

    return _children![i];
  }

  bool isSimilar(covariant WriteObject other) {
    if (size == other.size
        && text == other.text
        && childCount == other.childCount) {
          return true;
    }

    return false;
  }

  @override
  bool operator==(covariant WriteObject other) {
    if (!isSimilar(other)) {
      return false;
    } else if (hasChildren) {
      for (int i = 0; i < childCount; i++) {
        if (getChild(i) != other.getChild(i)) {
          return false;
        }
      }
    }

    return true;
  }
  
  @override
  int get hashCode => Object.hash(size, text, _children, parent);
}
