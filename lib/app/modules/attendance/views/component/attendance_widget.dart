// ignore_for_file: deprecated_member_use
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:isoweek/isoweek.dart';
import 'package:vkhealth/app/models/user_model.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/comfirm_dialog.dart';
import 'package:vkhealth/app/modules/global_widgets/tables/horizontal_data_table/horizontal_data_table.dart';
import 'package:vkhealth/common/ui.dart';

import '../../../../../common/helper.dart';
import '../../../../../common/size_config.dart';
import '../../../../models/response_models/attendance/employee_attendance.dart';
import '../../../global_widgets/avatar.dart';
import '../create_date_schedule_view.dart';
import '../date_over_time_view.dart';
import '../detailed_schedule_view.dart';

class AttendanceWidget extends StatefulWidget {
  final Week week;
  final List<EmployeeAttendance> employeesAttendance;
  final Function(String) deleteSchedule;
  final bool haveFunction;

  const AttendanceWidget(
      {Key key,
      this.week,
      this.employeesAttendance,
      this.deleteSchedule,
      this.haveFunction = true})
      : super(key: key);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  Week week;
  final CustomPopupMenuController _customPopupMenuController =
      CustomPopupMenuController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    week = widget.week;
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
      leftHandSideColumnWidth: 60,
      rightHandSideColumnWidth: week.days.length * 70.0,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: widget.employeesAttendance.length,
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
    data.add(FlatButton(
      padding: const EdgeInsets.all(0),
      child: _getTitleItemWidget('Tên NV', 80),
      onPressed: () {},
    ));

    data.addAll(
        week.days.map((e) => _getSecondTitleItemWidget(e, 60)).toList());
    return data;
  }

  Widget _generateFirstColumnRow(BuildContext context, int index,
      {Alignment alignment = Alignment.center}) {
    return InkWell(
      onTap: () {},
      child: CustomPopupMenu(
        child: Container(
            width: 80,
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
                      urlImage:
                          widget.employeesAttendance[index].employee.image,
                      name: widget.employeesAttendance[index].employee.name,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.employeesAttendance[index].employee.name,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.center,
              ),
            )),
        menuBuilder: () {
          return _buildShowDialog(widget.employeesAttendance[index].employee,
              widget.employeesAttendance[index]);
        },
        barrierColor: Colors.transparent,
        pressType: PressType.singleClick,
      ),
    );
  }

  Widget _buildShowDialog(Employee employee, EmployeeAttendance attendance) {
    return Container(
      height: SizeConfig.screenHeight * 0.2,
      width: SizeConfig.screenWidth * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          CircleAvatar(
              radius: 20,
              backgroundImage:
                  employee.image != null ? NetworkImage(employee.image) : null,
              child: Center(
                child: employee.image == null
                    ? Text(
                        employee.name.substring(0, 1),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      )
                    : null,
              )),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${employee.name}(${employee.code})",
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.group,
                size: 16,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                employee.position != null ? employee.position.name : "",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.wysiwyg,
                size: 16,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                employee.unit != null ? employee.unit.name : "",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.account_balance_outlined,
                size: 16,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                employee.site != null ? employee.site.name : "",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionDialog(Employee employee, EmployeeAttendance attendance,
      Attendances currentAttendance) {
    return Container(
      height: SizeConfig.screenHeight * 0.2,
      width: SizeConfig.screenWidth * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              GestureBinding.instance.handlePointerEvent(const PointerDownEvent(
                position: Offset(0, 0),
              ));
              Helper.changePage(
                  context, DetailedScheduleView(currentAttendance, employee));
            },
            child: Container(
              color: Colors.lightBlueAccent.withOpacity(.2),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Row(
                children: const [
                  Icon(Icons.remove_red_eye_sharp),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Xem chi tiết",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          currentAttendance.schedule == null ||
                  currentAttendance.schedule.overtimeShift == null
              ? InkWell(
                  onTap: () {
                    GestureBinding.instance
                        .handlePointerEvent(const PointerDownEvent(
                      position: Offset(0, 0),
                    ));
                    Helper.changePage(
                        context, DateOverTimeView(currentAttendance, employee));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Đăng kí tăng ca",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
          InkWell(
            onTap: () {
              showComfirmDialog(context, "Có chắc chắn muốn xóa không?",
                  onSuccessTap: () {
                widget.deleteSchedule(currentAttendance.schedule.id);
              });
            },
            child: Container(
              color: Colors.lightBlueAccent.withOpacity(.2),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Row(
                children: const [
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Xóa lịch làm việc",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
        children: week.days.map((e) {
      try {
        Attendances currentAttendance = widget
            .employeesAttendance[index].attendances
            .firstWhere((element) => e.day == DateTime.parse(element.date).day);
        return CustomPopupMenu(
          child: Container(
            child: Center(
              child: attendanceInfo(
                widget.employeesAttendance[index],
                currentAttendance,
              ),
            ),
            width: 60,
            height: 100,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          menuBuilder: () {
            if (widget.haveFunction) {
              return _buildFunctionDialog(
                  widget.employeesAttendance[index].employee,
                  widget.employeesAttendance[index],
                  currentAttendance);
            }
            return null;
          },
          barrierColor: Colors.transparent,
          position: PreferredPosition.top,
          pressType: PressType.singleClick,
        );
      } catch (e) {
        return Container();
      }
    }).toList());
  }

  Widget attendanceInfo(
      EmployeeAttendance employeeAttendance, Attendances currentAttendance) {
    return currentAttendance != null
        ? currentAttendance.schedule != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getShiftColor(currentAttendance)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        getShiftCode(currentAttendance),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  currentAttendance.schedule == null ||
                          currentAttendance.schedule.overtimeShift == null
                      ? Container()
                      : const Text(
                          "Tăng ca",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ).marginOnly(top: 5),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    checkingDataText(currentAttendance),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  currentAttendance.schedule.timeOff != null
                      ? Center(
                          child: Text(
                              currentAttendance
                                  .schedule.timeOff.type.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.green,
                              )),
                        )
                      : Container()
                ],
              )
            : InkWell(
                onTap: () {
                  Helper.changePage(
                      context, CreateDateScheduleView(employeeAttendance));
                },
                child: const SizedBox(
                    width: 150,
                    height: 100,
                    child: Center(
                        child: Icon(
                      Icons.add,
                      size: 13,
                    ))),
              )
        : Container();
  }

  Color getShiftColor(Attendances currentAttendance) {
    try {
      Color color = Ui.parseColor(currentAttendance.schedule.shift.colour);
      return color;
    } catch (e) {
      return Colors.transparent;
    }
  }

  String getShiftCode(Attendances currentAttendance) {
    try {
      String code = currentAttendance.schedule.shift.code;
      return code;
    } catch (e) {
      return "";
    }
  }

  String checkingDataText(Attendances currentAttendance) {
    String result = "-- -- -> -- --";
    if (currentAttendance == null) {
      return "";
    }
    if (currentAttendance.statistic != null) {
      if (currentAttendance.statistic.checkIn != null) {
        DateTime dateTime =
            DateTime.parse(currentAttendance.statistic.checkIn.time);
        result =
            "${dateTime.hour < 10 ? "0${dateTime.hour}" : dateTime.hour} : ${dateTime.minute < 10 ? "0${dateTime.minute}" : dateTime.minute} ->";
        if (currentAttendance.statistic.checkOut != null) {
          DateTime dateTime =
              DateTime.parse(currentAttendance.statistic.checkOut.time);
          result =
              "$result ${dateTime.hour < 10 ? "0${dateTime.hour}" : dateTime.hour} : ${dateTime.minute < 10 ? "0${dateTime.minute}" : dateTime.minute}";
        } else {
          result = "$result --  --";
        }
      } else if (currentAttendance.statistic.checkOut != null) {
        DateTime dateTime =
            DateTime.parse(currentAttendance.statistic.checkOut.time);
        result =
            "--  -- -> ${dateTime.hour < 10 ? "0${dateTime.hour}" : dateTime.hour} : ${dateTime.minute < 10 ? "0${dateTime.minute}" : dateTime.minute}";
      }
    }

    return result;
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
        decoration: const BoxDecoration(),
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
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ));
  }

  Widget _getSecondTitleItemWidget(DateTime label, double width) {
    return Container(
        width: width,
        height: 60,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Helper.getWeekDateString(label.weekday),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              label.day.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            )
          ],
        )));
  }
}
