
import 'package:get/get.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';

import '../models/response_models/attendance/schedule_swagger.dart';

class MealRepository {
  DotnetProvider _dotnetProvider;

  MealRepository(){
    _dotnetProvider = Get.find<DotnetProvider>();
  }

  Future<List<ScheduleGroup>> getScheduleGroup(){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getScheduleGroup();
  }
}
