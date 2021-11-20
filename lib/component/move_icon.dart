import 'package:flutter/material.dart';

import 'dart:math' as math;

class MoveIcon extends StatelessWidget {
  const MoveIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: 0.5 * math.pi, child: const Icon(Icons.compare_arrows));
  }
}
