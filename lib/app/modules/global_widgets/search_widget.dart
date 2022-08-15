import 'package:flutter/material.dart';

import '../../../common/ui.dart';

class SearchWidget extends StatelessWidget {
  final ValueChanged onChanged;
  final ValueChanged onSummited;
  final String title;
  final double width;
  final double height;

  const  SearchWidget({Key key, this.onChanged, this.onSummited, this.title, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        decoration: BoxDecoration(
            color: Ui.parseColor("#ebeced"),
            borderRadius: BorderRadius.circular(20),
            border: Border.all( color: Colors.grey.withOpacity(.2),)
        ),
        child: Center(
          child: TextField(
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16
            ),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintStyle: const TextStyle(fontSize: 18, color: Colors.black),
              hintText: title,
              prefixIcon: const Icon(Icons.search),
              labelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 10 ),
            ),
            onChanged: onChanged,
            onSubmitted: onSummited,
          ),
        ));
  }
}
