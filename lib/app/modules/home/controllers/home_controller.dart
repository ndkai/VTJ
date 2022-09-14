import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../services/auth_service.dart';

class HomeController extends GetxController {
  final Rx<User> currentUser = Get.find<AuthService>().user;
}
