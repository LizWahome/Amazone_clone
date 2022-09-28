import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomButton(
      {super.key,
      required this.child,
      required this.color,
      required this.isLoading,
      required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        fixedSize: Size(screenSize.width * 0.5, 40),
      ),
      child: widget.child,
      // child: !widget.isLoading
      //     ? const CircularProgressIndicator()
      //     : const AspectRatio(
      //         aspectRatio: 1 / 1,
      //         child: CircularProgressIndicator(
      //           color: Colors.white,
      //         ),
      //       ),
    );
  }
}
