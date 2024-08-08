import 'package:flutter/material.dart';

class InsttantButtomWidget extends StatelessWidget {
  const InsttantButtomWidget(
      {super.key,
      required this.title,
      required this.color,
      required this.onPressed});
  final String title;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
