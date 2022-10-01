import 'package:amazon_clone/utilis/constants.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(preferredSize: const Size.fromHeight(kAppBarHeight), hasBackButton: true, isReadOnly: false,),
      body: const Center(
    child: Text("HomeScreen"),
  ), 
    );
  }
}