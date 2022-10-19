import 'package:amazon_clone/widgets/loading_widget.dart';
import 'package:amazon_clone/widgets/results_widget.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("products")
                      .where("productName", isEqualTo: query)
                      .get(),
                  builder: ((context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else {
                      return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 2 / 3),
                          itemBuilder: ((context, index) {
                            ProductModel product =
                                ProductModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                            return ResultsWidget(product: product);
                          }));
                    }
                  })))
        ],
      ),
    );
  }
}
