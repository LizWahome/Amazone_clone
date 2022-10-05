import 'package:amazon_clone/utilis/color_theme.dart';
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
      width: screenSize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              productaName,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.7,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CostWidget(color: Colors.black, cost: cost),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Sold by ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  TextSpan(
                    text: sellerName,
                    style: const TextStyle(color: activeCyanColor, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
