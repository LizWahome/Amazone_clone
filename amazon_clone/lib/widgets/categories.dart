import 'package:amazon_clone/utilis/constants.dart';
import 'package:flutter/material.dart';

import '../screens/results_screen.dart';

class CategoriesHorizontalListViewBar extends StatelessWidget {
  const CategoriesHorizontalListViewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    ResultsScreen(query: categoriesList[index]))));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(categoryLogos[index])
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(categoriesList[index]),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    ));
  }
}