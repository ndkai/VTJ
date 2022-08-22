import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AttendanceStatusItem extends StatelessWidget {
  final double size;
  final Color color;
  final String title;
  const AttendanceStatusItem({Key key, this.size, this.color, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Text(
            "  $title",
            style: TextStyle(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}
