import 'package:flutter/material.dart';

class ToggleWidget extends StatefulWidget {
  final int selected;
  final String fn;
  final String sn;
  final ValueChanged<int> onChanged;
  const ToggleWidget({Key key, this.selected, this.onChanged, this.fn, this.sn})
      : super(key: key);

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  int selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        item(selected == 0, widget.fn, 0),
        item(selected == 1, widget.sn, 1),
      ],
    );
  }

  Widget item(bool isEnable, String name, int setValue) {
    return InkWell(
      onTap: () {
        widget.onChanged(setValue);
        setState(() {
          selected = setValue;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: isEnable ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          name,
          style: TextStyle(
              color: isEnable ? Colors.white : Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
