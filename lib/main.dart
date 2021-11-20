import 'package:einkaufsliste/list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          title: 'Einkaufsliste',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ListPage(title: 'Einkaufsliste'),
        ));
  }
}
