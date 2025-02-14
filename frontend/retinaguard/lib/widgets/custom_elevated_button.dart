import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton(
      {required this.width,
      required this.height,
      required this.hintText,
      required this.onPressed,
      super.key});
  final double width;
  final double height;
  final String hintText;
  final Function() onPressed;
  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[500]),
          onPressed: widget.onPressed,
          child: Text(widget.hintText,style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
