library hive_listener;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveListener extends StatelessWidget {
  final Box box;
  final List<String> keys;
  final Widget Function(Box bx) builder;

  const HiveListener({Key key, @required this.box, this.keys, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: box.listenable(keys: keys),
      builder: (c, bx, w) => builder(bx),
    );
  }
}
