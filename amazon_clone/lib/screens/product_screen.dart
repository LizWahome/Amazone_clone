import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/model/review_model.dart';
import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_rounded_button.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:amazon_clone/widgets/review_dialog.dart';
import 'package:amazon_clone/widgets/review_widget.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

import '../utilis/constants.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productmodel;
  const ProductScreen({super.key, required this.productmodel});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded somespace = Expanded(child: Container());
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: SearchBarWidget(
          preferredSize: const Size.fromHeight(kAppBarHeight),
          isReadOnly: true,
          hasBackButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height -
                        (kAppBarHeight + (kAppBarHeight / 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        widget.productmodel.sellerName,
                                        style: const TextStyle(
                                          color: activeCyanColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Text(widget.productmodel.productName),
                                  ],
                                ),
                                RatingWidget(rating: widget.productmodel.rating)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: screenSize.height / 3,
                              constraints: BoxConstraints(
                                  maxHeight: screenSize.height / 3),
                              child: Image.network(widget.productmodel.url),
                            ),
                          ),
                          somespace,
                          CostWidget(
                              color: Colors.black,
                              cost: widget.productmodel.cost),
                          somespace,
                          CustomButton(
                              color: Colors.orange,
                              isLoading: false,
                              onPressed: () {},
                              child: const Text("Buy Now",
                                  style: TextStyle(color: Colors.black))),
                          CustomButton(
                              color: yellowColor,
                              isLoading: false,
                              onPressed: () {},
                              child: const Text("Add to cart",
                                  style: TextStyle(color: Colors.black))),
                          somespace,
                          CustomSimpleRoundedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => const ReviewDialog());
                              },
                              text: "Add a review for this product"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ReviewWidget(
                            review: ReviewModel(
                                senderName: "Inc Tech",
                                description:
                                    "Best price you could ever get, grab yours now",
                                rating: 3));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const UserDetailBar(
            offset: 0,
          ),
        ],
      ),
    ));
  }
}
