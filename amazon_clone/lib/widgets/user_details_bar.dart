import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:amazon_clone/utilis/constants.dart';
import 'package:flutter/material.dart';

class UserDetailBar extends StatelessWidget {
  final double offset;
  const UserDetailBar({super.key, required this.offset});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Positioned(
      top: -offset /3,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: lightBackgroundaGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 20,
          ),
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.location_on_outlined,
                color: Color.fromARGB(252, 77, 76, 76),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.7,
              child: const Text(
                "Address - Deliver...",
                style: TextStyle(color: Color.fromARGB(252, 77, 76, 76 )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
