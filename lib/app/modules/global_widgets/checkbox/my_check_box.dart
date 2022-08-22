import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const MyCheckBox({Key key, this.value = false, this.onChanged})
      : super(key: key);

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        onChanged: (b) {
          setState(() {
            value = b;
          });
          widget.onChanged(b);
        });
  }
}
