import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/attendance/employee_attendance.dart';
import 'package:vkhealth/common/size_config.dart';
import 'package:vkhealth/common/ui.dart';

import '../../../../../common/helper.dart';
import '../../../global_widgets/buttons/block_button_widget.dart';
import '../../../global_widgets/text_field_widget.dart';

class AttendanceFixedDialog extends StatefulWidget {
  final CheckIn checkIn;
  final CheckIn checkout;
  final DateTime date;
  final Function(String note, DateTime ciTime, DateTime coTime) onTapDone;
  const AttendanceFixedDialog({Key key, this.checkIn, this.checkout, this.onTapDone, this.date}) : super(key: key);

  @override
  State<AttendanceFixedDialog> createState() => _AttendanceFixedDialogState();
}

class _AttendanceFixedDialogState extends State<AttendanceFixedDialog> {
  String checkinTime;
  String checkoutTime;
  TextEditingController cocl = TextEditingController();
  TextEditingController cicl = TextEditingController();
  TextEditingController reasonCl = TextEditingController();
  bool startTomorow = false;
  DateTime citime;
  DateTime cotime;


  @override
  void initState() {
    citime = widget.date;
    cotime = widget.date;
    // if(widget.checkIn == null || widget.checkIn.time.isEmpty){
    //   cicl.text = Helper.getHourByDate(widget.checkIn.time);
    // } else {
    //   cicl.text = Helper.getHourByDate(widget.checkIn.time);
    // }
    //
    // cocl.text = Helper.getHourByDate(widget.checkout.time);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.8,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sửa chấm công", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(height: 25,),
            TextFieldWidget(

              onTap: () async {
                DateTime dt = await DatePicker.showTimePicker(context, showSecondsColumn: false, locale: LocaleType.vi);
                if(dt != null){
                  citime = DateTime(
                    citime.year,
                    citime.month,
                    citime.day,
                    dt.hour,
                    dt.minute,
                    dt.second,
                  );
                  cicl.text  = Helper.getHourByDateTime(citime);
                }
              },
              keyboardType: TextInputType.none,
              labelText: "Chấm công vào",
              controller: cicl,
              hintText: "",
              isEdit: false,
              initialValue: checkinTime,
              suffixIcon: InkWell(

                child: const Icon(Icons.lock_clock),
              ),
              labelStyle:
              const TextStyle(color: Colors.grey, fontSize: 22),
              // controller: controller.genderEdt,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            // Row(
            //   children: [
            //     Checkbox(value: true, onChanged: (v){}),
            //     const Text("Bắt đầu vào ngày hôm sau", style: TextStyle(color: Colors.black, fontSize: 18),),
            //   ],
            // ),
            TextFieldWidget(
              keyboardType: TextInputType.none,
              labelText: "Chấm công ra",
              hintText: "",
              initialValue: checkoutTime,
              controller: cocl,
              isEdit: false,
              onTap: () async {
                DateTime dt = await DatePicker.showTimePicker(context, showSecondsColumn: false, locale: LocaleType.vi);
                if(dt != null){
                  cotime = DateTime(
                    cotime.year,
                    cotime.month,
                    cotime.day,
                    dt.hour,
                    dt.minute,
                    dt.second,
                  );
                  cocl.text  = Helper.getHourByDateTime(cotime);
                }
              },
              suffixIcon: InkWell(

                child: const Icon(Icons.lock_clock),
              ),
              labelStyle:
              const TextStyle(color: Colors.grey, fontSize: 22),
              // controller: controller.genderEdt,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Row(
              children: [
                Checkbox(value: startTomorow, onChanged: (v){
                  setState(() {
                    startTomorow = !startTomorow;
                  });
                }),
                const Text("Bắt đầu vào ngày hôm sau", style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            const Text("Lý do", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            TextFormField(
              maxLines: 3,
              controller: reasonCl,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18
              ),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                  )
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlockButtonWidget(
                  onPressed: () {
                    if (citime.difference(cotime).inSeconds > 0) {
                      if(!startTomorow){
                        Get.showSnackbar(Ui.RemindSnackBar(
                            message: "Thời gian kết thúc phải trước thời gian bắt đầu"));
                        return;
                      }
                        cotime = DateTime(cotime.year, cotime.month, cotime.day + 1, cotime.hour, cotime.minute);
                    }
                    if(reasonCl.text.isEmpty){
                      Get.showSnackbar(Ui.RemindSnackBar(
                          message: "Lý do không được bỏ trống"));
                      return;
                    }
                    widget.onTapDone(reasonCl.text, citime, cotime);
                    Navigator.pop(context);

                  },
                  color: Colors.green,
                  text: Text(
                    "Xác nhận",
                    style: Get.textTheme.headline6.merge(
                        TextStyle(color: Get.theme.primaryColor)),
                  ),
                  borderRadius: 10,
                ).paddingSymmetric(vertical: 10, horizontal: 3),
                BlockButtonWidget(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.red,
                  text: Text(
                    "Đóng",
                    style: Get.textTheme.headline6.merge(
                        TextStyle(color: Get.theme.primaryColor)),
                  ),
                  borderRadius: 10,
                ).paddingSymmetric(vertical: 10, horizontal: 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
                                                                              