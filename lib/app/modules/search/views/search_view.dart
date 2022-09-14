import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/search/controllers/search_controller.dart';

import '../../../../common/helper.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        body: ListView(
          children: const [
            Center(
              child: Text(
                "Công việc",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
