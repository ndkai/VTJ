import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/meal/controllers/meal_controller.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/helper.dart';
import '../../global_widgets/dialog/choose_scheduleGroup/choose_schedule_group_dialog.dart';
import '../../global_widgets/pages/base_page.dart';
import 'components/toggle_widget.dart';

class MealManagePage extends GetView<MealController>{
  const MealManagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getScheduleGroup(context);
    return BasePage(
      title: "Quản lý cơm",
        child: SizedBox(
          height: SizeConfig.screenHeight * 0.91,
          child: Obx(
              (){
                return ListView(
                  primary: true,
                  children: [
                    ToggleWidget(
                      onChanged: (n){
                        controller.selectedStatic.value = n;
                      },
                      selected: controller.selectedStatic.value,
                    ).marginOnly(bottom: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            // ignore: missing_return
                            showScheduleGroupDialog(context, controller.scheduleGroup, (v){
                              controller.currentScheduleGroup.value = v;
                            });
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.5,
                            height: 70,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Obx(
                                    (){
                                  if(controller.currentScheduleGroup.value.name == null){
                                    return Container();
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(controller.currentScheduleGroup.value.code, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(controller.currentScheduleGroup.value.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16, overflow: TextOverflow.fade),),
                                          Text("${controller.currentScheduleGroup.value.employeeIds.length} nhân viên", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16, overflow: TextOverflow.fade),),
                                        ],
                                      )

                                    ],
                                  );
                                }
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  controller.currentDate.value = controller.currentDate.value.subtract(const Duration(days: 1));
                                },
                                child: const Icon(Icons.arrow_back_ios, size: 17,color: Colors.black54),
                              ),
                              Obx(
                                  (){
                                    return Text(Helper.getVietnameseTime(controller.currentDate.value.toIso8601String()), style: const TextStyle(color: Colors.black54, fontSize: 17),);
                                  }
                              ),
                              InkWell(
                                onTap: (){
                                  controller.currentDate.value =  controller.currentDate.value.add(const Duration(days: 1));
                                },
                                child: const Icon(Icons.arrow_forward_ios, size: 17,color: Colors.black54),
                              ),
                              Row(
                                children: [

                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                );
              }
          ),
        ),
    );
  }


}