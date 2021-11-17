import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Einkaufsliste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Einkaufsliste'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _list = ["Butter", "Milch", "Käse"];

  void _addListItem() {
    setState(() {
      _list.add("");
    });
  }

  void _updateListOrder(int oldIndex, int newIndex) {
    // dragging from top to bottom
    if (oldIndex < newIndex) {
      int end = newIndex - 1;
      String startItem = _list[oldIndex];
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
      String startItem = _list[oldIndex];
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
                  key: Key(e),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black54)),
                  child: ListTile(
                    key: Key(e),
                    title: Text(e),
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
