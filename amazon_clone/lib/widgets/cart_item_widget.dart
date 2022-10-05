import 'package:amazon_clone/utilis/color_theme.dart';
import 'package:amazon_clone/widgets/product_information_widget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
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
          Expanded(flex: 5,child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width/3,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.network("https://m.media-amazon.com/images/I/11yLyO9f9ZL._SX90_SY90_.png")),
              ),
              const ProductInformationWidget(productaName: "Video Games", cost: 1000.5, sellerName: "Gucci")
            ],
          )),
          Expanded(flex: 1,child: Container(color: Colors.blue,),),
          Expanded(flex: 1,child: Container(color: Colors.green,),),
        ],
      ),
    );
  }
}
