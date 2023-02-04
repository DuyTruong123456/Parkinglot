import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sqlite.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
class MyCheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: GetData(),
    );
  }
}
class GetData extends StatefulWidget {
  @override
  _MyInsert createState() => _MyInsert();
}
int checkcamera=0;
int id=0;
var mathe="abcde";
var hinhxe,hinhbienso;
var time= DateTime.now().toString();
class _MyInsert extends State<GetData> {
  FutureOr<String> insert(String id,String thexe) async {

    final response = await http.get(Uri.parse('http://192.168.1.12//CarParkAPI/insert.php?id=$id&thexe=$thexe'));


    if (response.statusCode == 200) {
      throw Exception('thành công');

    } else {

      throw Exception('Không nhận được tín hiệu');

    }
  }
  //0 if chụp hình xe ,1 if chụp biển số
  void SaveID(idsave) async{
    SharedPreferences SaveId= await SharedPreferences.getInstance();
    if(SaveId.getInt("id")==null)SaveId.setInt("id", 0);
    else SaveId.setInt("id", idsave);
  }

  void LoadID() async{
    SharedPreferences LoadId=await SharedPreferences.getInstance();
    if(LoadId.getInt("id")==null)LoadId.setInt("id", 0);
    else
    {
      setState(() {
        id=LoadId.getInt("id")!;
      });
    }

  }
  SnackBar snackBar = SnackBar(
    content: Text('Đã lưu!'),
    duration: Duration(seconds: 2),
  );
  Widget submitBtn(){
    return ElevatedButton(onPressed: (){
      insertdata();
      updatethe();
      SaveID(id+1);
      LoadID();
      insert(id.toString(),mathe);
      hinhxe=null;
      hinhbienso=null;
      getdata();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }, child: Text('submit'));
  }
  Widget ID(){
    LoadID();
    return Text(id.toString());
  }
  Widget Mathe(){
    return Text("Mã thẻ: $mathe");
  }
  Widget Hinhxe(){

    return Container(child: RotatedBox(quarterTurns: 0 ,child:Image.file((File(hinhxe)))),height:300,width:300);
  }
  Widget Hinhbienso(){
    return Container(child: RotatedBox(quarterTurns: 0 ,child:Image.file((File(hinhbienso)))),height:300,width:300);

  }
  Widget Cameraxe(){
    return ElevatedButton(onPressed:(){
      checkcamera=0;
      findcamera();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraExampleHome()),
      );
    }, child:Text('Chụp hình xe'));
  }
  Widget Camerabienso(){

    return ElevatedButton(onPressed:(){
      checkcamera=1;
      findcamera();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraExampleHome()),
      );
    }, child:Text('Chụp hình biển số'));
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
                SizedBox(height:10),
                ID(),
                SizedBox(height:10),
                Mathe(),
                SizedBox(height:10),
                Cameraxe(),
                SizedBox(height:10),
                if(hinhxe!=null) Hinhxe(),
                SizedBox(height:10),
                Camerabienso(),
                SizedBox(height:10),
                if(hinhbienso!=null)Hinhbienso(),
                SizedBox(height:10),
                if(hinhxe!=null&&hinhbienso!=null)submitBtn(),
              ]
          )));
        }));
  }
}
