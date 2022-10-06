import 'package:amazon_clone/utilis/constants.dart';
import 'package:amazon_clone/widgets/category_widget.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
          preferredSize: const Size.fromHeight(kAppBarHeight),
          isReadOnly: true,
          hasBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categoriesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.2 / 3.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemBuilder: ((context, index) => CategoryWidget(index: index)),
        ),
      ),
    );
  }
}
