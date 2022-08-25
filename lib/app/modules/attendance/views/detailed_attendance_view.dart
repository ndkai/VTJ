import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/attendance/attendance_detailed.dart';
import 'package:vkhealth/common/app_constant.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/helper.dart';
import '../../../models/user_model.dart' as user;
import '../../global_widgets/pages/base_page.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/attendance_controller.dart';

class DetailedAttendanceView extends GetView<AttendanceController> {
  final AttendanceDetailSwagger attendanceDetailSwagger;
  final user.Employee employee;
  const DetailedAttendanceView(this.attendanceDetailSwagger, this.employee,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Chi tiết chấm công",
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Thông tin nhân viên",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              TextFieldWidget(
                keyboardType: TextInputType.none,
                labelText: "Mã nhân viên",
                hintText: "",
                initialValue: employee.code,
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                // controller: controller.genderEdt,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              TextFieldWidget(
                keyboardType: TextInputType.none,
                labelText: "Họ và tên",
                hintText: "",
                initialValue: employee.name,
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                // controller: controller.genderEdt,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Chi tiết chấm công",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              Container(
                color: Colors.grey.withOpacity(.2),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    Center(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.2,
                        child: const Center(
                          child: Text(
                            "Thời gian",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.33,
                        child: const Center(
                          child: Text(
                            "Loại thiết bị",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.33,
                        child: const Center(
                          child: Text(
                            "Loại chấm công",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: ListView(
                  children: attendanceDetailSwagger.data
                      .map((e) => Container(
                            color: Colors.grey.withOpacity(.1),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Row(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: SizeConfig.screenWidth * 0.2,
                                    child: Center(
                                      child: Text(
                                        Helper.getHourByDate(e.time),
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: SizeConfig.screenWidth * 0.33,
                                    child: const Center(
                                      child: Text(
                                        "Kiosk",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: SizeConfig.screenWidth * 0.33,
                                    child: Center(
                                      child: Text(
                                        AppConstants.attendanceMethod[
                                            e.attendanceMethod],
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          )),
    );
  }
}
