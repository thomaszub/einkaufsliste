import 'package:flutter/material.dart';

class CheckWidget extends StatelessWidget {
  final bool done;

  const CheckWidget(Key? key, this.done) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (done) {
      return const Icon(Icons.check_box);
    } else {
      return const Icon(Icons.check_box_outline_blank);
    }
  }
}
