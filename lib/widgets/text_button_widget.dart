import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final double letterSpace;
  final Color textColor;
  final VoidCallback function;

  const TextButtonWidget(
      {Key? key,
      required this.function,
      required this.text,
      required this.textColor,
      required this.textSize,
      required this.letterSpace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            color: textColor,
            fontSize: textSize,
            letterSpacing: letterSpace,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
