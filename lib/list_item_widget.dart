import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final String _text;

  const ListItemWidget(Key key, this._text) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        key: key,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: ListTile(
          key: key,
          title: Text(_text),
        ));
  }
}
