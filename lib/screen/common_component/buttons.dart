import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';

class Mybutton1 extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const Mybutton1({super.key, required this.label, required this.onPressed});

  @override
  State<Mybutton1> createState() => _Mybutton1State();
}

class _Mybutton1State extends State<Mybutton1> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed,
      child: Text(widget.label),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.color1),
      ),
    );
  }
}
