import 'package:amazon_clone/utilis/constants.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchSreen extends StatelessWidget {
  const SearchSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(preferredSize: const Size.fromHeight(kAppBarHeight), isReadOnly: false, hasBackButton: true),
    );
  }
}