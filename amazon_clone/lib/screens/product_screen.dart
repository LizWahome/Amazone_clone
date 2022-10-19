import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/model/review_model.dart';
import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:amazon_clone/utilis/utilis.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_rounded_button.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:amazon_clone/widgets/review_dialog.dart';
import 'package:amazon_clone/widgets/review_widget.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/order_request_model.dart';
import '../model/user_details_model.dart';
import '../provider/user_details_provider.dart';
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
                              onPressed: () async {
                                await CloudFirestore().addProductToOrders(
                                    model: widget.productmodel, userDetails: Provider.of<UserDetailsProvider>(context, listen: false).userDetails);
                                Utilis().showSnackBar(context, "Done");
                              },
                              child: const Text("Buy Now",
                                  style: TextStyle(color: Colors.black))),
                          CustomButton(
                              color: yellowColor,
                              isLoading: false,
                              onPressed: () async {
                                await CloudFirestore().addProductToCart(
                                    productModel: widget.productmodel);
                                Utilis().showSnackBar(context, "Added to cart");
                              },
                              child: const Text("Add to cart",
                                  style: TextStyle(color: Colors.black))),
                          somespace,
                          CustomSimpleRoundedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => ReviewDialog(
                                        productUid: widget.productmodel.uid));
                              },
                              text: "Add a review for this product"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: screenSize.height,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("products")
                            .doc(widget.productmodel.uid)
                            .collection("reviews")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            return ListView.builder(
                              itemBuilder: ((context, index) {
                                ReviewModel model =
                                    ReviewModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return ReviewWidget(review: model);
                              }),
                              itemCount: snapshot.data!.docs.length,
                            );
                          }
                        },
                      )),
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

class CloudFirestore {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future addProductToOrders(
      {required ProductModel model,
      required UserDetailsModel userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequest(model: model, userDetails: userDetails);
  }

  Future sendOrderRequest(
      {required ProductModel model,
      required UserDetailsModel userDetails}) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        orderName: model.productName, buyersAddress: userDetails.address);
    await firebaseFirestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("ordersRequests")
        .add(orderRequestModel.getJson());
  }
}
