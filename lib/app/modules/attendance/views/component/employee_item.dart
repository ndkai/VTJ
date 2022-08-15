import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/response_models/user/employee_swagger.dart';
import '../../../global_widgets/avatar.dart';

class EmployeeItem extends StatefulWidget {
  final EmployeeData employeeData;
  final ValueChanged<EmployeeData> onChanged;
  const EmployeeItem({Key key, this.employeeData, this.onChanged}) : super(key: key);

  @override
  State<EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends State<EmployeeItem> {
  EmployeeData employeeData;
  @override
  void initState() {
    employeeData = widget.employeeData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return item(widget.employeeData);
  }

  Widget item(EmployeeData employeeData){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            UserAvatar(
              radius: 17,
              name: employeeData.name,
              urlImage: employeeData.image,
            ).marginOnly(right: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(employeeData.code, style: const TextStyle(fontSize: 18, color: Colors.black),),
                Text(employeeData.name, style: const TextStyle(fontSize: 16, color: Colors.grey),),
              ],
            ),
          ],
        ),
        Checkbox(
          value: employeeData.isChoose, onChanged: (bool value) {
          setState(() {
            employeeData.isChoose = !employeeData.isChoose;
            widget.onChanged(employeeData);
          });
        },
        ),
      ],
    );
  }
}
