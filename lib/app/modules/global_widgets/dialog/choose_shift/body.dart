// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../../../../common/size_config.dart';
import '../../../../models/response_models/attendance/shift_response.dart';

class ShiftSelectBody extends StatefulWidget {
  final Function(ShiftData) onSuccess;
  final List<ShiftData> list;
  const ShiftSelectBody({Key key, this.onSuccess, this.list}) : super(key: key);

  @override
  _ShiftSelectBodyState createState() => _ShiftSelectBodyState();
}

class _ShiftSelectBodyState extends State<ShiftSelectBody> {
  int val = -1;
  ShiftData shiftData;
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.4)
        ),
        child: SizedBox(
          height: SizeConfig.screenHeight * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.screenHeight * 0.4,
                child: ListView(
                  children: lists(),
                ),
              ),

              SizedBox(height: SizeConfig.screenHeight * 0.01,),
              const Divider(color: Colors.black, height: 1,),
              SizedBox(height: SizeConfig.screenHeight * 0.02,),
              Expanded(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                          ),
                          width: SizeConfig.screenWidth * 0.25,
                          child: Center(
                            child: Text("Hủy bỏ", style: TextStyle(
                              color: Colors.blue,
                              fontSize: SizeConfig.screenWidth * 0.045,

                            )),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        widget.onSuccess
                          (shiftData);
                      },

                      child: Container(
                          decoration: const BoxDecoration(
                          ),
                          width: SizeConfig.screenWidth * 0.25,
                          child: Center(
                            child: Text("Đồng ý", style: TextStyle(
                                color: Colors.blue,
                                fontSize: SizeConfig.screenWidth * 0.045,
                                fontWeight: FontWeight.bold
                            ),),
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  List<Widget> lists(){
    return widget.list.map((e) =>
        MediaQuery.removePadding(context: context,
            removeLeft: true,
            child: ListTile(
          title: Text(e.name, style: const TextStyle(color: Colors.black),),
          leading: Radio(
            value: e.hashCode,
            groupValue: val,
            onChanged: (value) {
              setState(() {
                print("value $value");
                val = value as int;
                shiftData = e;
              });
            },
            activeColor: Colors.green,
          ),
        ))
    ).toList();
  }
}
