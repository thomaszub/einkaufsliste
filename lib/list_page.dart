import 'package:einkaufsliste/component/list_item_widget.dart';
import 'package:einkaufsliste/model/list_item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<ListItem> _list = [];

  void _addListItem() {
    setState(() {
      _list.add(ListItem(Key(uuid.v4()), ""));
    });
  }

  void _updateListOrder(int oldIndex, int newIndex) {
    setState(() {
      // dragging from top to bottom
      if (oldIndex < newIndex) {
        final end = newIndex - 1;
        final startItem = _list[oldIndex];
        var i = 0;
        var local = oldIndex;
        do {
          _list[local] = _list[++local];
          i++;
        } while (i < end - oldIndex);
        _list[end] = startItem;
      }
      // dragging from bottom to top
      else if (oldIndex > newIndex) {
        final startItem = _list[oldIndex];
        for (var i = oldIndex; i > newIndex; i--) {
          _list[i] = _list[i - 1];
        }
        _list[newIndex] = startItem;
      }
    });
  }

  void _updateListItem(ListItem newItem) {
    setState(() {
      _list[_list.indexWhere((e) => e.key == newItem.key)] = newItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ReorderableListView(
          children:
              _list.map((e) => ListItemWidget(e, _updateListItem)).toList(),
          onReorder: _updateListOrder),
      floatingActionButton: FloatingActionButton(
        onPressed: _addListItem,
        tooltip: 'Neuer Eintrag',
        child: const Icon(Icons.add),
      ),
    );
  }
}
