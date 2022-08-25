import '../app/models/request_models/meal/meal_shift.dart';
import '../app/models/request_models/meal/unit.dart';

class AppConstants {
  static List<String> dateInWeek = [
    "  Thứ 2  ",
    "  Thứ 3  ",
    "  Thứ 4  ",
    "  Thứ 5  ",
    "  Thứ 6  ",
    "  Thứ 7  ",
    " Chủ nhật ",
  ];

  static List<MealShift> shiftTypes = [
    MealShift("Ca ngày", 0),
    MealShift("Ca đêm", 1),
    MealShift("Tăng ca ngày", 2),
    MealShift("Tăng ca đêm", 3),
  ];

  static List<String> attendanceMethod = [
    "ATTENDANCE MANUAL",
    "FACEID",
    "MOBILE",
    "QR"
  ];

  static List<AppUnit> appUnits = [
    AppUnit("Khối", 0),
    AppUnit("Phòng ban", 1),
    AppUnit("Bộ phận", 2),
    AppUnit("Tổ nhóm", 3),
  ];
}
