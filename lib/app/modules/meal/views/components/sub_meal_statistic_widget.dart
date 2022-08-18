import 'package:flutter/material.dart';
import 'package:vkhealth/app/models/request_models/meal/meal_statistic.dart';
import 'package:vkhealth/app/models/response_models/meal/meal_overview.dart';
import 'package:vkhealth/app/modules/global_widgets/tables/horizontal_data_table/horizontal_data_table.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../../common/app_constant.dart';
import '../../../global_widgets/avatar.dart';
import '../../../global_widgets/checkbox/my_check_box.dart';

class SubMealStatisticWidget extends StatefulWidget {
  final List<ChildUnits> data;

  // final ValueChanged<MealOverView> onChanged;
  const SubMealStatisticWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  State<SubMealStatisticWidget> createState() =>
      _SubMealStatisticWidgetState();
}

class _SubMealStatisticWidgetState extends State<SubMealStatisticWidget> {
  bool chooseAll = false;
  List<ChildUnits> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      width: SizeConfig.screenWidth,
      child: table(),
    );
  }

  Widget table() {
    return HorizontalDataTable(
      leftHandSideColumnWidth: 120,
      rightHandSideColumnWidth: 1400,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: data.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black54,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
    );
  }

  List<Widget> _getTitleWidget() {
    List<Widget> data = <Widget>[];
    // ignore: deprecated_member_use
    data.add(FlatButton(
      padding: const EdgeInsets.all(0),
      child: _getTitleItemWidget('Tên NV', 200),
      onPressed: () {},
    ));

    data.add(FlatButton(
      padding: const EdgeInsets.all(0),
      child: _getEmployeeTitleWidget('Nhân sự'),
      onPressed: () {},
    ));

    data.add(FlatButton(
      padding: const EdgeInsets.all(0),
      child: _getShiftTitleItemWidget('Kế hoạch', 200),
      onPressed: () {},
    ));

    data.add(FlatButton(
      padding: const EdgeInsets.all(0),
      child: _getShiftTitleItemWidget('Thực tế', 200),
      onPressed: () {},
    ));
    data.add(FlatButton(
      padding: const EdgeInsets.all(0),
      child: _getTotalTitleWidget('Tổng'),
      onPressed: () {},
    ));
    return data;
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        mealTypeCountItem(
            data[index].unit.prescribedPersonnel.toString(), index,
            width: 66.6),
        mealTypeCountItem(data[index].unit.actualPersonnel.toString(), index,
            width: 66.6),
        mealTypeCountItem(data[index].registeredEmployeeTotal.toString(), index,
            width: 66.6),
        //ke hoach
        mealTypeCountItem(
            data[index].estimate.normalShift.carnivore.toString(), index),
        //ca ngay man
        mealTypeCountItem(
            data[index].estimate.normalShift.vegetarian.toString(), index),
        //ca ngay chay
        mealTypeCountItem(
            data[index].estimate.nightShift.carnivore.toString(), index),
        //ca dem man
        mealTypeCountItem(
            data[index].estimate.nightShift.vegetarian.toString(), index),
        //ca dem chay
        mealTypeCountItem(
            data[index].estimate.overtimeDayShift.carnivore.toString(), index),
        //tc ngay man
        mealTypeCountItem(
            data[index].estimate.overtimeDayShift.vegetarian.toString(), index),
        //tc ngay chay
        mealTypeCountItem(
            data[index].estimate.overtimeNightShift.carnivore.toString(),
            index),
        //tca dem man
        mealTypeCountItem(
            data[index].estimate.overtimeNightShift.vegetarian.toString(),
            index),
        //tca dem chay
        //thuc te
        mealTypeCountItem(
            data[index].actual.normalShift.carnivore.toString(), index),
        //ca ngay man
        mealTypeCountItem(
            data[index].actual.normalShift.vegetarian.toString(), index),
        //ca ngay chay
        mealTypeCountItem(
            data[index].actual.nightShift.carnivore.toString(), index),
        //ca dem man
        mealTypeCountItem(
            data[index].actual.nightShift.vegetarian.toString(), index),
        //ca dem chay
        mealTypeCountItem(
            data[index].actual.overtimeDayShift.carnivore.toString(), index),
        //tc ngay man
        mealTypeCountItem(
            data[index].actual.overtimeDayShift.vegetarian.toString(), index),
        //tc ngay chay
        mealTypeCountItem(
            data[index].actual.overtimeNightShift.carnivore.toString(), index),
        //tca dem man
        mealTypeCountItem(
            data[index].actual.overtimeNightShift.vegetarian.toString(), index),
        //tca dem chay //tca dem chay
        mealTypeCountItem(
            (data[index].estimate.normalShift.carnivore +
                data[index].estimate.normalShift.vegetarian +
                data[index].estimate.nightShift.carnivore +
                data[index].estimate.nightShift.vegetarian +
                data[index].estimate.overtimeDayShift.carnivore +
                data[index].estimate.overtimeDayShift.vegetarian +
                data[index].estimate.overtimeNightShift.vegetarian +
                data[index].actual.overtimeNightShift.carnivore)
                .toString(),
            index, width: 70),
        // tong
        mealTypeCountItem(
            (data[index].actual.normalShift.carnivore +
                data[index].actual.normalShift.vegetarian +
                data[index].actual.nightShift.carnivore +
                data[index].actual.nightShift.vegetarian +
                data[index].actual.overtimeDayShift.carnivore +
                data[index].actual.overtimeDayShift.vegetarian +
                data[index].actual.overtimeNightShift.vegetarian +
                data[index].actual.overtimeNightShift.carnivore)
                .toString(),
            index, width: 70),
      ],
    );
  }

  Widget mealTypeCountItem(String val, int index, {double width = 62.5}) {
    return InkWell(
        onTap: () {},
        child: Container(
            width: width,
            height: 50,
            decoration: BoxDecoration(
              border: index == data.length - 1
                  ? const Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  horizontal: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ))
                  : const Border.symmetric(
                  vertical: BorderSide(color: Colors.black, width: 0.5)),
            ),
            child: Center(
              child: Text(
                val,
                style: const TextStyle(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            )));
  }

  Widget _generateFirstColumnRow(BuildContext context, int index,
      {Alignment alignment = Alignment.center}) {
    return InkWell(
        onTap: () {},
        child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              border: index == data.length - 1
                  ? const Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  horizontal: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ))
                  : const Border.symmetric(
                  vertical: BorderSide(color: Colors.black, width: 0.5)),
            ),
            child: Center(
              child: Text(
                data[index].unit.name,
                style: const TextStyle(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            )));
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: Colors.black, width: 0.5),
              horizontal: BorderSide(color: Colors.black, width: 0.5)),
        ),
        width: width,
        height: 108,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ));
  }

  Widget _getTotalTitleWidget(String label) {
    return Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: Colors.black, width: 0.5),
              horizontal: BorderSide(color: Colors.black, width: 0.5)),
        ),
        width: 141,
        height: 108,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              height: 66,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Center(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )),
            ),
            const Divider(
              color: Colors.black,
              height: 1,
            ),
            Row(
              children: [
                Container(
                  width: 70,
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(color: Colors.black, width: 0.5),
                        horizontal: BorderSide(color: Colors.black, width: 1)),
                  ),
                  child: const Center(
                      child: Text(
                        "Kế hoạch",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Container(
                  width: 70,
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(color: Colors.black, width: 0.5),
                        horizontal: BorderSide(color: Colors.black, width: 1)),
                  ),
                  child: const Center(
                      child: Text(
                        "Thực tế",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Widget _getEmployeeTitleWidget(String label) {
    return Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: Colors.black, width: 0.5),
              horizontal: BorderSide(color: Colors.black, width: 0.5)),
        ),
        width: 200,
        height: 108,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              height: 66,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Center(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )),
            ),
            const Divider(
              color: Colors.black,
              height: 1,
            ),
            Row(
              children: [
                Container(
                  width: 66.3,
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(color: Colors.black, width: 0.5),
                        horizontal: BorderSide(color: Colors.black, width: 1)),
                  ),
                  child: const Center(
                      child: Text(
                        "Định mức",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Container(
                  width: 66.3,
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(color: Colors.black, width: 0.5),
                        horizontal: BorderSide(color: Colors.black, width: 1)),
                  ),
                  child: const Center(
                      child: Text(
                        "Danh sách",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      )),
                ),
                Container(
                  width: 66.3,
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(color: Colors.black, width: 0.5),
                        horizontal: BorderSide(color: Colors.black, width: 1)),
                  ),
                  child: const Center(
                      child: Text(
                        "Đk Cơm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Widget _getShiftTitleItemWidget(String label, double width) {
    return Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: Colors.black, width: 0.5),
              horizontal: BorderSide(color: Colors.black, width: 0.5)),
        ),
        width: 500,
        height: 108,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Center(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )),
            ),
            const Divider(
              color: Colors.black,
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AppConstants.shiftTypes
                  .map((e) => Container(
                width: 500 / AppConstants.shiftTypes.length - 1,
                height: 40,
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                      vertical:
                      BorderSide(color: Colors.black, width: 0.5),
                      horizontal:
                      BorderSide(color: Colors.black, width: 1)),
                ),
                child: Center(
                    child: Text(
                      e.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    )),
              ))
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AppConstants.shiftTypes
                  .map((e) => Row(
                children: [
                  Container(
                    width: 250 ~/ AppConstants.shiftTypes.length * 1.0,
                    height: 40,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                          vertical: BorderSide(
                              color: Colors.black, width: 0.5),
                          horizontal: BorderSide(
                              color: Colors.black, width: 1)),
                    ),
                    child: const Center(
                        child: Text(
                          "Mặn",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        )),
                  ),
                  Container(
                    width: 250 ~/ AppConstants.shiftTypes.length * 1.0,
                    height: 40,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                          vertical: BorderSide(
                              color: Colors.black, width: 0.5),
                          horizontal: BorderSide(
                              color: Colors.black, width: 1)),
                    ),
                    child: const Center(
                        child: Text(
                          "Chay",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        )),
                  ),
                ],
              ))
                  .toList(),
            ),
          ],
        ));
  }
}
