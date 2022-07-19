import 'package:flutter/material.dart';

class ToggleWidget extends StatefulWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const ToggleWidget({Key key, this.selected, this.onChanged}) : super(key: key);

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
          item(selected==0, "Hôm nay", 0),
          item(selected==1, "Thống kê", 1),
        ],
    );
  }

  Widget item(bool isEnable, String name, int setValue){
    return InkWell(
      onTap: (){
         widget.onChanged(setValue);
         setState(() {
           selected = setValue;
         });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isEnable ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(
          name,
          style: TextStyle(
              color: isEnable ? Colors.white : Colors.black,
              fontSize: 18
          ),
        ),
      ),
    );
  }
}
