import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:amazon_clone/widgets/custom_rounded_button.dart';
import 'package:amazon_clone/widgets/custom_square_buttom.dart';
import 'package:amazon_clone/widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                   ProductScreen(productmodel: product))));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenSize.width / 3,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Center(
                            child: Image.network(
                               product.url),
                          )),
                    ),
                     ProductInformationWidget(
                        productaName:
                           product.productName,
                        cost: product.cost,
                        sellerName: product.sellerName)
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomSquareButton(
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(Icons.remove),
                ),
                CustomSquareButton(
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40,
                    child: const Text(
                      "0",
                      style: TextStyle(color: activeCyanColor),
                    )),
                CustomSquareButton(
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CustomSimpleRoundedButton(
                            onPressed: () {}, text: "Delete"),
                        const SizedBox(width: 5),
                        CustomSimpleRoundedButton(
                            onPressed: () {}, text: "Save for later"),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "See more of this",
                            style: TextStyle(color: activeCyanColor),
                          )),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
