import 'package:einkaufsliste/list_item.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ListItemWidget extends StatefulWidget {
  final ListItem _item;
  final void Function(ListItem) _callback;

  ListItemWidget(this._item, this._callback) : super(key: _item.key);

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        key: widget.key,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: ListTile(
            key: widget.key,
            leading: IconButton(
              icon: const Icon(Icons.check_box),
              onPressed: null,
            ),
            //leading: const Icon(Icons.check_box_outline_blank),
            title: TextField(
              controller: _controller,
              onSubmitted: (value) =>
                  widget._callback(ListItem(widget._item.key, value)),
            ),
            trailing: Transform.rotate(
                angle: 0.5 * math.pi,
                child: const Icon(Icons.compare_arrows))));
  }
}
