import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:amazon_clone/utilis/utilis.dart';
import 'package:amazon_clone/widgets/cart_item_widget.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/order_request_model.dart';
import '../model/user_details_model.dart';
import '../utilis/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
          preferredSize: const Size.fromHeight(kAppBarHeight),
          isReadOnly: true,
          hasBackButton: false),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: kAppBarHeight / 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("cart")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomButton(
                          color: yellowColor,
                          isLoading: true,
                          onPressed: () {},
                          child: const Text("loading"),
                        );
                      } else {
                        return CustomButton(
                          color: yellowColor,
                          isLoading: false,
                          onPressed: () async {
                            await CloudFirestore().buyAllItemsInCart(userDetails: Provider.of<UserDetailsProvider>(context, listen: false).userDetails);
                            Utilis().showSnackBar(context, "Done");
                          },
                          child: Text(
                            "Proceed to buy(${snapshot.data!.docs.length})",
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }
                    }),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                ProductModel model =
                                    ProductModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return CartItemWidget(product: model);
                              }));
                        }
                      })),
            ],
          ),
          const UserDetailBar(
            offset: 0,
          ),
        ],
      ),
    );
  }
}

class CloudFirestore {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future buyAllItemsInCart({required UserDetailsModel userDetails}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel model =
          ProductModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, userDetails: userDetails);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders({required ProductModel model, required UserDetailsModel userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequest(model: model, userDetails: userDetails);
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
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
