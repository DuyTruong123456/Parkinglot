import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:giuxe/result.dart';
import 'package:giuxe/sqlite.dart';

class SearchPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
var now=DateTime.now();
var date1=DateTime.now();
var date2=DateTime.now();
var time1=DateTime.now();
var time2=DateTime.now();
var datetime1=DateTime.parse(date1.toString().substring(0,10)+' '+time1.toString().substring(11,19));
var datetime2=DateTime.parse(date2.toString().substring(0,10)+' '+time2.toString().substring(11,19));
class _MyAppState  extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {


    return  Scaffold(

        appBar: AppBar(title: const Text('Giữ xe')),
        body: Builder(builder: (BuildContext context) {

          return Column(children:[
            Row(children:[
              Flexible(child: Text('Từ ngày:'),flex:2,fit:FlexFit.tight),
              Flexible(flex:4,fit:FlexFit.tight,
                  child: ElevatedButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true, onChanged: (date) {

                            }, onConfirm: (date) {
                              setState(() {
                                date1=date;
                                datetime1=DateTime.parse(date1.toString().substring(0,10)+' '+time1.toString().substring(11,19));

                              });
                              print('confirm $date');
                            }, currentTime: DateTime.now(), locale: LocaleType.vi);
                      },
                      child: Text(
                        date1.toString().substring(0,10),
                        style: TextStyle(color: Colors.black),
                      ))
              ),
              Flexible(child: Text(' lúc :'),flex:1,fit:FlexFit.tight,),
              Flexible(flex:4,fit:FlexFit.tight,
                  child: ElevatedButton(
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            showTitleActions: true, onChanged: (time) {

                            }, onConfirm: (time) {
                              print('confirm $time');
                              setState(() {
                                time1=time;
                                datetime1=DateTime.parse(date1.toString().substring(0,10)+' '+time1.toString().substring(11,19));

                              });
                            }, currentTime: DateTime.now(), locale: LocaleType.vi);
                      },
                      child: Text(
                        time1.toString().substring(11,19),
                        style: TextStyle(color: Colors.black),
                      ))
              ),
            ]),
            SizedBox(height:10),
            Row(children:[
              Flexible(child: Text('Đến ngày:'),flex:2,fit:FlexFit.tight),
              Flexible(flex:4,fit:FlexFit.tight,
                  child: ElevatedButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true, onChanged: (date) {

                            }, onConfirm: (date) {
                              setState(() {
                                date2=date;
                                datetime2=DateTime.parse(date2.toString().substring(0,10)+' '+time2.toString().substring(11,19));

                              });
                              print('confirm $date');
                            }, currentTime: DateTime.now(), locale: LocaleType.vi);
                      },
                      child: Text(
                        date2.toString().substring(0,10),
                        style: TextStyle(color: Colors.black),
                      ))
              ),
              Flexible(child: Text(' lúc :'),flex:1,fit:FlexFit.tight,),
              Flexible(flex:4,fit:FlexFit.tight,
                  child: ElevatedButton(
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            showTitleActions: true, onChanged: (time) {

                            }, onConfirm: (time) {
                              print('confirm $time');
                              setState(() {
                                time2=time;
                                datetime2=DateTime.parse(date2.toString().substring(0,10)+' '+time2.toString().substring(11,19));

                              });
                            }, currentTime: DateTime.now(), locale: LocaleType.vi);
                      },
                      child: Text(
                        time2.toString().substring(11,19),
                        style: TextStyle(color: Colors.black),
                      ))
              ),
            ]),
            ElevatedButton(onPressed: (){

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultPage()),
              );
            }, child: Text('tìm'))
          ]);
        }));
  }
}