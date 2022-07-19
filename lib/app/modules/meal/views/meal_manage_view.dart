import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/meal/controllers/meal_controller.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/helper.dart';
import '../../global_widgets/pages/base_page.dart';
import 'components/toggle_widget.dart';

class MealManagePage extends GetView<MealController>{
  const MealManagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        Container(
                          width: SizeConfig.screenWidth * 0.5,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blue,
                                  width: 1
                              ),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            children: const [],
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