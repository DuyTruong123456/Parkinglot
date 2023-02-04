import 'dart:async';
import 'dart:io';
import 'package:animated_button/animated_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:giuxe/search.dart';
import 'camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sqlite.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'result.dart';

class GetInfo extends StatefulWidget {
  @override
  _MyInfo createState() => _MyInfo();
}
var hinhxe,hinhbienso;
class _MyInfo extends State<GetInfo> {
  void Deletehinhxe() async {
    SharedPreferences saveimg= await SharedPreferences.getInstance();

    try {
      final file =  File(saveimg.getString("hinhxe"+id.toString()+time.toString())!);

      await file.delete();
      print('deleted');
    } catch (e) {
      return;
    }
  }
  void Deletehinhbienso() async {
    SharedPreferences saveimg= await SharedPreferences.getInstance();

    try {
      final file =  File(saveimg.getString("hinhbienso"+id.toString()+time.toString())!);

      await file.delete();
      print('deleted');
    } catch (e) {
      return;
    }
  }

  Widget Hinhxe(){
    return Container(child: RotatedBox(quarterTurns: 0 ,child:Image.file((File(hinhxe)))),height:300,width:300);
  }
  Widget Hinhbienso(){
    return Container(child: RotatedBox(quarterTurns: 0 ,child:Image.file((File(hinhbienso)))),height:300,width:300);

  }
  Widget DeleteBTN(){
    return ElevatedButton(onPressed:(){
      Deletehinhxe();
      Deletehinhbienso();
      deletedata(int.parse(id));
      setState(() {
        children;
      });
    }, child: Text('xóa thông tin'));
  }
  Widget ReportBTN(){
    return AnimatedButton(
        color: Colors.grey,
        shadowDegree: ShadowDegree.light,
        onPressed:(){
          setState(() {

          });
        }, child:Row(mainAxisSize: MainAxisSize.min,
        children:[
          Icon(Icons.warning,color:Colors.amberAccent,size:50),
          Text('Báo mất thẻ',style:TextStyle(color:Colors.black)),
          Icon(Icons.warning,color:Colors.amberAccent,size:50),
        ]));
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(title: const Text('Thông tin')),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(child:Center(child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text(id),
                SizedBox(height:10),
                Text(time),
                SizedBox(height:10),
                Text('Hình Xe'),
                if(hinhxe!=null) Hinhxe()
                else Text('không có'),
                SizedBox(height:10),
                Text('Hình Biển Số'),
                if(hinhbienso!=null)Hinhbienso()
                else Text('không có'),
                DeleteBTN(),
                ReportBTN(),
              ]
          )));
        }));
  }
}
