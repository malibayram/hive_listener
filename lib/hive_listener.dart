library hive_listener;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveListener<T> extends StatefulWidget {
  final Box<T> box;
  final List<String>? keys;

  /// if you want to close your box when disposing set [closeOnDispose] to true
  final bool closeOnDispose;
  final Widget Function(Box<T> bx) builder;

  const HiveListener({
    Key? key,
    required this.box,
    this.keys,
    required this.builder,
    this.closeOnDispose = false,
  }) : super(key: key);

  @override
  _HiveListenerState createState() => _HiveListenerState();
}

class _HiveListenerState<T> extends State<HiveListener<T>> {
  late Box<T> _box;
  bool _boxOpened = false;

  void _valueChanged() {
    _box = widget.box;
    setState(() {});
  }

  @override
  void initState() {
    _box = widget.box;
    _boxOpened = _box.isOpen;
    if (_boxOpened)
      _box.listenable(keys: widget.keys).addListener(_valueChanged);
    else {
      Hive.openBox<T>(_box.name).then((value) {
        _box = value;
        _boxOpened = _box.isOpen;
        _box.listenable(keys: widget.keys).addListener(_valueChanged);
        setState(() {});
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    if (_boxOpened)
      _box.listenable(keys: widget.keys).removeListener(_valueChanged);

    if (widget.closeOnDispose) widget.box.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_box);
  }
}
