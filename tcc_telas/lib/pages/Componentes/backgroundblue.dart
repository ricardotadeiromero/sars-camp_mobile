import 'package:flutter/material.dart';

class Backgroundblue extends StatelessWidget {
  final Color coor;

  Backgroundblue({required this.coor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: coor,
    );
  }
}
