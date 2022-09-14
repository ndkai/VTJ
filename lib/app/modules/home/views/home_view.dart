import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/home/controllers/home_controller.dart';
import 'package:vkhealth/app/routes/app_routes.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';
import 'package:vkhealth/common/ui.dart';

import 'components/home_function_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            child: Stack(
              children: [
                Image.asset(
                  "assets/img/home_bg.png",
                  width: SizeConfig.screenWidth,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Xin chào quay lại!",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      (controller.currentUser.value.userInfo.employee!= null && controller.currentUser.value.userInfo != null)
                          ? controller.currentUser.value.userInfo.employee.name
                          : "",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                      softWrap: true,
                    ),
                  ],
                ).marginOnly(left: 10)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  primary: true,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Dịch vụ của tôi",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ).paddingOnly(left: 15, bottom: 10),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        Helper.checkHavePermission("ATTENDANCE_PAGE")
                            ? HomeFunctionCard(
                                title: "Lịch làm việc",
                                onTap: () {
                                  // Get.toNamed(Routes.E_ATTENDANCE);
                                  Helper.changePageWithPermission(() {
                                    Get.toNamed(Routes.ATTENDANCE);
                                  }, "ATTENDANCE_PAGE", showMessage: true);
                                },
                                image: "assets/icon/calendar.png",
                                bgColor: Ui.parseColor("#219653"))
                            : Container(),
                        Helper.checkHavePermission("TIME_OFF_PAGE")
                            ? HomeFunctionCard(
                                title: "Quản lý nghỉ phép",
                                onTap: () {
                                  Helper.changePageWithPermission(() {
                                    Get.toNamed(Routes.TIMEOFF);
                                  }, "TIME_OFF_PAGE");
                                },
                                image: "assets/icon/calendar-tick.png",
                                bgColor: Ui.parseColor("#E86993"),
                              )
                            : Container(),
                        Helper.checkHavePermission("MEAL_PAGE")
                            ? HomeFunctionCard(
                                title: "Quản lý cơm",
                                onTap: () {
                                  Helper.changePageWithPermission(() {
                                    Get.toNamed(Routes.MEAL_MANAGE);
                                  }, "MEAL_PAGE");
                                },
                                image: "assets/icon/meal.png",
                                bgColor: Ui.parseColor("#F47048"))
                            : Container(),
                      ],
                    ).marginOnly(bottom: 20),
                    // const Text(
                    //   "Lịch hẹn sắp tới của bạn",
                    //   style: TextStyle(fontSize: 18, color: Colors.black54),
                    // ).paddingOnly(left: 15, bottom: 10, top: 35),
                    // const Divider(
                    //   height: 2,
                    //   color: Colors.grey,
                    // ),
                  ],
                )),
          )
        ],
      )),
    );
  }
}
