import 'package:flutter/material.dart';

class SimpleProductWidget extends StatelessWidget {
  final String url;
  const SimpleProductWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1/1,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.network(url),
        ),
      ),
    );
  }
}
