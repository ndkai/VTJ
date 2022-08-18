import '../app/models/request_models/meal/meal_shift.dart';

class AppConstants{
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
}