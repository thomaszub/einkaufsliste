import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:einkaufsliste/list_item.dart';

const uuid = Uuid();

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Einkaufsliste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EinkaufslistePage(title: 'Einkaufsliste'),
    );
  }
}

class EinkaufslistePage extends StatefulWidget {
  const EinkaufslistePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EinkaufslistePage> createState() => _EinkaufslistePageState();
}

class _EinkaufslistePageState extends State<EinkaufslistePage> {
  final List<ListItem> _list = [];

  void _addListItem() {
    setState(() {
      _list.add(ListItem(uuid.v4(), ""));
    });
  }

  void _updateListOrder(int oldIndex, int newIndex) {
    // dragging from top to bottom
    if (oldIndex < newIndex) {
      int end = newIndex - 1;
      ListItem startItem = _list[oldIndex];
      int i = 0;
      int local = oldIndex;
      do {
        _list[local] = _list[++local];
        i++;
      } while (i < end - oldIndex);
      _list[end] = startItem;
    }
    // dragging from bottom to top
    else if (oldIndex > newIndex) {
      ListItem startItem = _list[oldIndex];
      for (int i = oldIndex; i > newIndex; i--) {
        _list[i] = _list[i - 1];
      }
      _list[newIndex] = startItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ReorderableListView(
          children: _list
              .map((e) => Container(
                  key: Key(e.key),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black54)),
                  child: ListTile(
                    key: Key(e.key),
                    title: Text(e.text),
                  )))
              .toList(),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              _updateListOrder(oldIndex, newIndex);
            });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addListItem,
        tooltip: 'Neuer Eintrag',
        child: const Icon(Icons.add),
      ),
    );
  }
}
