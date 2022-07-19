import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isoweek/isoweek.dart';
import '../../../../../common/helper.dart';
import '../../../../../common/size_config.dart';
import '../../../../models/response_models/attendance/employee_attendance.dart';

class AttendanceWidget extends StatefulWidget {
  final Week week;
  final List<EmployeeAttendance> employeesAttendance;
  const AttendanceWidget({Key key, this.week, this.employeesAttendance}) : super(key: key);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  ScrollController controller = ScrollController();
  ScrollController controller2 = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.addListener((){
    //   setState(() {
    //     controller2.jumpTo( controller.offset);
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    print("dddd ${widget.employeesAttendance.length}");
    return Column(
      children: [
        Row(
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     CircleAvatar(
            //       backgroundColor: Colors.blue,
            //       radius: 10,
            //     ),
            //     Text("Nguyễn Hoàng Nhật Duy", style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center,)
            //   ],
            // ),
            Container(
                width: 80,
                child: const Text("Tên NV", style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.center,)
            ),
            Container(
              width: SizeConfig.screenWidth - 110,
              height: 60,
              child:  ListView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: widget.week.days.map((e) => timeItem(e)).toList(),
              ),
            )
          ],
        ),
        Row(
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     CircleAvatar(
            //       backgroundColor: Colors.blue,
            //       radius: 10,
            //     ),
            //     Text("Nguyễn Hoàng Nhật Duy", style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center,)
            //   ],
            // ),
            Container(
                width: 80,
                height: 500,
                child: ListView(
                  controller: controller2,
                  scrollDirection: Axis.vertical,
                  children: widget.employeesAttendance.map((e) => Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(e.employee.name, style: const TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.center,),
                  )).toList(),
                )
            ),
          ],
        )
      ],
    );
  }

  Widget timeItem(DateTime dateTime){
    return Container(
      height: 60,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // color: Colors.orange
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Helper.getWeekDateString(dateTime.weekday), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),),
          Text(dateTime.day.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),),
        ],
      ),
    );
  }
}
