import 'package:amazon_clone/widgets/results_widget.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../utilis/constants.dart';

class ResultsScreen extends StatelessWidget {
  final String query;
  const ResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
          preferredSize: const Size.fromHeight(kAppBarHeight),
          isReadOnly: false,
          hasBackButton: true),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Showing results for ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    )),
                TextSpan(
                    text: query,
                    style: const TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                    )),
              ])),
            ),
          ),
          Expanded(
            child: GridView.builder(
                itemCount: 9,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2/3),
                itemBuilder: ((context, index) {
                  return ResultsWidget(
                    product: ProductModel(
                        url:
                            "https://cdn.pixabay.com/photo/2016/12/23/07/01/game-1926907_1280.png",
                        productName: "Video games",
                        cost: 574,
                        discount: 0,
                        uid: "hsjszncdjh",
                        sellerName: "Games.com",
                        sellerUid: "ksdjasd",
                        rating: 4,
                        noOfRating: 5000),
                  );
                })),
          )
        ],
      ),
    );
  }
}
