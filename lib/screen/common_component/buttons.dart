import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';

class Mybutton1 extends StatelessWidget {
  final String label;
  const Mybutton1({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      child: Text(label),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.color1),
      ),
    );
  }
}
