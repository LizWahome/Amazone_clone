import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/utilis/constants.dart';
import 'package:flutter/material.dart';

class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  const AccountScreenAppBar({super.key, required this.preferredSize});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Container(
        height: kAppBarHeight,
        width: screenSize.width,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.network(
                amazonLogoUrl,
                height: kAppBarHeight * 0.7,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchSreen()));
                    },
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
