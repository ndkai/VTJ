import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';

import '../controllers/timeoff_controller.dart';
import 'make_timeoff_form_view.dart';

class TimeOffViewManager extends GetView<TimeOffController> {
  const TimeOffViewManager({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getEmployeeTimeOff();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            Helper.changePage(context, const MakeTimeOffView());
          },
        ),
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Text('Tất cả', style: TextStyle(fontSize: 13, color: Colors.white),)),
              Tab(icon: Text('Chờ duyệt', style: TextStyle(fontSize: 13,color: Colors.white),)),
              Tab(icon: Text('Thành công', style: TextStyle(fontSize: 13,color: Colors.white),)),
              Tab(icon: Text('Từ chối', style: TextStyle(fontSize: 13, color: Colors.white),)),
            ],
            indicatorColor: Colors.white,
          ),
          title: const Text('Quản lý nghỉ phép', style: TextStyle(fontSize: 24),),
          centerTitle: true,

        ),
        body: TabBarView(
          children: [
            item(),
            item(id: 1),
            item(id: 3),
            item(id: 4),
          ],
        ),
      ),
    );
  }

  Widget item({int id, Function onTap}){
    return Obx(
        (){
          return ListView(
            children: (id != null ? controller.employeesTimeOff.where((element) => element.logs.last.status == id) : controller.employeesTimeOff).map((e){
              return InkWell(
                onTap: onTap,
                child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 40, offset: const Offset(0, 15)),
                        BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 13, offset: const Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.type.description,
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              fontWeight: FontWeight.w200
                          ),
                        ).marginOnly(bottom: 10),
                        rowField("Nhân viên", e.employee.name),
                        rowField("Lý do nghỉ", e.type.description),
                        rowField("Từ ngày - đến ngày", "${Helper.getVietnameseTime(e.fromDate)} - ${Helper.getVietnameseTime(e.toDate)}"),
                        rowField("Tổng ngày", (DateTime.parse(e.toDate).difference(DateTime.parse(e.fromDate)).inDays + 1).toString()),
                        rowField("Trạng thái", controller.mapStatusToState(e.logs.last.status), contentColor: controller.mapStatusToColor(e.logs.last.status)),
                      ],
                    )
                ),
              );
            }).toList(),
          );
        }
    );
  }

  Widget rowField(String title, String content, {Color contentColor = Colors.black}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.black45, fontSize: 18),),
        Text("$content       ", style: TextStyle(color: contentColor, fontSize: 18),),
      ],
    ).marginOnly(bottom: 10);
  }
}
