import 'package:einkaufsliste/check_widget.dart';
import 'package:einkaufsliste/list_item.dart';
import 'package:einkaufsliste/move_icon.dart';
import 'package:flutter/material.dart';

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
    _controller = TextEditingController(text: widget._item.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget textWidget;
    if (widget._item.done) {
      textWidget = Text(_controller.text,
          style: const TextStyle(decoration: TextDecoration.lineThrough));
    } else {
      textWidget = TextField(
          controller: _controller,
          decoration: null,
          onSubmitted: (value) => {
                setState(() {
                  widget._callback(ListItem(widget._item.key, value));
                })
              });
    }

    return Container(
        key: widget.key,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: ListTile(
            key: widget.key,
            leading: IconButton(
              icon: CheckWidget(null, widget._item.done),
              onPressed: () => {
                setState(() {
                  widget._item.done = !widget._item.done;
                  widget._callback(widget._item);
                })
              },
            ),
            title: textWidget,
            trailing: const MoveIcon()));
  }
}
