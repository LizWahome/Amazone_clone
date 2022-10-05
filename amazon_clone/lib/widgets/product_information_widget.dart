import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productaName;
  final double cost;
  final String sellerName;
  const ProductInformationWidget(
      {super.key,
      required this.productaName,
      required this.cost,
      required this.sellerName});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width/2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(productaName, 
          maxLines: 2,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.7,
            overflow: TextOverflow.ellipsis,
          ),),
          CostWidget(color: Colors.black, cost: cost),
        ],
      ),
    );
  }
}
