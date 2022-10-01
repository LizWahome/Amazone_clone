import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:amazon_clone/utilis/constants.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;

  SearchBarWidget(
      {super.key,
      required this.preferredSize,
      required this.isReadOnly,
      required this.hasBackButton});

  @override
  final Size preferredSize;

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(color: Colors.grey, width: 1));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.cyan,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            hasBackButton
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back))
                : Container(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 7),
                    )
                  ]
                ),
                child: TextField(
                  readOnly: isReadOnly,
                  onTap: () {
                    if (isReadOnly) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const SearchSreen()));
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    fillColor: Colors.white,
                    filled: true,
                    border: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic_none_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
