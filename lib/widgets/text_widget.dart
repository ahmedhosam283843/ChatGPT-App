import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      this.color,
      required this.label,
      this.fontSize = 18,
      this.fontWeight})
      : super(key: key);

  final Color? color;
  final FontWeight? fontWeight;
  final double fontSize;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? Colors.white,
      ),
    );
  }
}