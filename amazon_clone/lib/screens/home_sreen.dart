import 'package:amazon_clone/model/user_details_model.dart';
import 'package:amazon_clone/utilis/constants.dart';
import 'package:amazon_clone/widgets/banner_ad.dart';
import 'package:amazon_clone/widgets/categories.dart';
import 'package:amazon_clone/widgets/products_show_case.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:amazon_clone/widgets/simple_product.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(
          preferredSize: const Size.fromHeight(kAppBarHeight),
          hasBackButton: true,
          isReadOnly: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              child: Column(children: [
                const SizedBox(height: kAppBarHeight/2,),
                const CategoriesHorizontalListViewBar(),
                const BannerAdWidget(),
                ProductShowCaseListView(
                    title: "Upto 70% off", children: testChildren),
                ProductShowCaseListView(
                    title: "Upto 60% off", children: testChildren),
                ProductShowCaseListView(
                    title: "Upto 50% off", children: testChildren),
                ProductShowCaseListView(
                    title: "Explore", children: testChildren),
              ]),
            ),
            UserDetailBar(offset: offset),
          ],
        ));
  }
}
