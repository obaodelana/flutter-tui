import 'package:meta/meta.dart';

import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/write_object.dart';

abstract class Widget {
  const Widget();

  WriteObject build(Size constraint);
}

abstract class StatelessWidget extends Widget {
  const StatelessWidget();
}

// abstract class StatefulWidget extends Widget {
//   const StatefulWidget();

//   @protected
//   State createState();
// }


// abstract class State<T extends StatefulWidget> {
//   T? _widget;

//   WriteObject build(Size constraint);
// }