import 'package:flutter/material.dart';
import 'package:vkhealth/app/models/response_models/meal/meal_overview.dart';
import 'package:vkhealth/app/modules/global_widgets/tables/horizontal_data_table/horizontal_data_table.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../../common/app_constant.dart';
import '../../../global_widgets/avatar.dart';
import '../../../global_widgets/checkbox/my_check_box.dart';

class TimeOffOverviewWidget extends StatefulWidget {
  final MealOverView overView;
  final ValueChanged<MealOverView> onChanged;
  const TimeOffOverviewWidget({Key key, this.overView, this.onChanged})
      : super(key: key);

  @override
  State<TimeOffOverviewWidget> createState() => _TimeOffOverviewWidgetState();
}

class _TimeOffOverviewWidgetState extends State<TimeOffOverviewWidget> {
  bool chooseAll = false;
  MealOverView overView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    overView = widget.overView;
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
      leftHandSideColumnWidth: 70,
      rightHandSideColumnWidth: (AppConstants.shiftTypes.length + 1) * 100.0,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: overView.data.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black54,
        height: 0.6,
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
      child: _getTitleItemWidget('NV', 200),
      onPressed: () {},
    ));

    data.addAll(AppConstants.shiftTypes
        .map((e) => _getTitleItemWidget(e.name, 70))
        .toList());
    data.add(Container(
        width: 100,
        height: 60,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Center(
          child: MyCheckBox(
            value: chooseAll,
            onChanged: (s) {
              chooseAll = s;
              MealOverView tOverView = MealOverView(data: []);
              if (chooseAll) {
                for (var i in overView.data) {
                  i.isChoose = true;
                  tOverView.data.add(i);
                }
                widget.onChanged(tOverView);
                setState(() {
                  overView = tOverView;
                });
              } else {
                for (var i in overView.data) {
                  i.isChoose = false;
                  tOverView.data.add(i);
                }
                widget.onChanged(tOverView);
                setState(() {
                  overView = tOverView;
                });
              }
            },
          ),
        )));
    return data;
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    List<Widget> widgets = AppConstants.shiftTypes.map((e) {
      Meals meal;
      try {
        for (var i in overView.data[index].meals) {
          if (i.shiftType == e.id) {
            meal = overView.data[index].meals.first;
            break;
          }
        }
        // ignore: empty_catches
      } catch (e) {}

      return Container(
        child: Center(
          child: meal == null
              ? const Text("")
              : Image.asset(
                  meal.mealType == 0
                      ? "assets/icon/vegan.png"
                      : "assets/icon/carnivore.png",
                  width: 30,
                ),
        ),
        width: 70,
        height: 100,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      );
    }).toList();
    widgets.add(Container(
      child: Center(
          child: Checkbox(
              value: overView.data[index].isChoose,
              onChanged: (b) {
                setState(() {
                  overView.data[index].isChoose =
                      !overView.data[index].isChoose;
                  widget.onChanged(overView);
                });
              })),
      width: 100,
      height: 100,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    ));
    return Row(children: widgets);
  }

  Widget _generateFirstColumnRow(BuildContext context, int index,
      {Alignment alignment = Alignment.center}) {
    return InkWell(
        onTap: () {},
        child: Container(
            width: 70,
            height: 100,
            padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserAvatar(
                      radius: 15,
                      urlImage: overView.data[index].employee.image,
                      name: overView.data[index].employee.name,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      overView.data[index].employee.name,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 8),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.center,
              ),
            )));
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
        width: width,
        height: 60,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ));
  }
}
