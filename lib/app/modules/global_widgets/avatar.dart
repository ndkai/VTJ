import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final String urlImage;
  final String name;
  const UserAvatar({Key key, this.urlImage, this.name, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
        radius: radius,
        backgroundImage: urlImage != null ?
        NetworkImage(urlImage) : null,
        child: Center(
          child: urlImage == null ?
          Text(name.substring(0,1), style: const TextStyle(color: Colors.black, fontSize: 20),
          ): null,
        ));
  }
}
