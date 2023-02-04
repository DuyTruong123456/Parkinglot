
import 'dart:async';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giuxe/camera.dart';
import 'package:giuxe/search.dart';
import 'package:giuxe/sqlite.dart';
import 'checkin.dart';
import 'checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'firebase.dart';

class LoginPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
String username='';
class _MyAppState extends State<LoginPage> {
  var checkfirsttime=true;//change to false to activate account
  var checksecondtime=true;//change to false to activate password

  final myAccountController = TextEditingController();
  final myPasswordController = TextEditingController();
  FutureOr<String> CheckAccount(String account) async {

    final response = await http.get(Uri.parse('http://192.168.1.12//CarParkAPI/account.php?taikhoan=$account'));


    if (response.statusCode == 200) {
      String data=response.body;
      setState(() {
        checkfirsttime = json.decode(data)["check"];
      });
      print(myAccountController.text);
      print('checkfirsttime:$checkfirsttime');
      throw Exception('nhận được tín hiệu');
    } else {

      throw Exception('Không nhận được tín hiệu');

    }
  }
  FutureOr<String> CheckPassword(String account,String password) async {

    final response = await http.get(Uri.parse('http://192.168.1.12//CarParkAPI/password.php?taikhoan=$account&matkhau=$password'));


    if (response.statusCode == 200) {
      String data=response.body;
      setState(() {
        checksecondtime = json.decode(data)["check"];
        username = json.decode(data)["hoten"];
      });
      print(myAccountController.text);
      print('checksecondtime:$checksecondtime');
      throw Exception('nhận được tín hiệu');
    } else {

      throw Exception('Không nhận được tín hiệu');

    }
  }
  Widget accountcheck(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Tài khoản',

        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,

          height: 60.0,
          child: TextField(
            controller: myAccountController,

            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(

              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              hintText: 'Nhập tài khoản',

            ),
          ),
        ),
      ],
    );

  }
  Widget passwordcheck() {
    if(checkfirsttime==true)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mật Khẩu',

        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,

          height: 60.0,
          child: TextField(
            controller: myPasswordController,

            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(

              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.password,
                color: Colors.black,
              ),
              hintText: 'Nhập mật khẩu',

            ),
          ),
        ),
      ],
    );
    else if(checkfirsttime==false&&myAccountController.text!='') return Text('Sai tài khoản');
    else return SizedBox();
  }
  Widget NextBTN(){
    return ElevatedButton(onPressed:(){
      setState(() {
        if(checkfirsttime==false) {
          CheckAccount(myAccountController.text);
        }
        if(checkfirsttime==true&&checksecondtime==false)
        {
          CheckPassword(myAccountController.text, myPasswordController.text);

        }
        if(checkfirsttime==true&&checksecondtime==true)
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCheckIn()),
          );
        }
      });
    }, child: Text('Next'));
  }
  Widget functionlist(){
    return Column(children:[
      SizedBox(height:10),
      AnimatedButton(
          color: Colors.grey,
          shadowDegree: ShadowDegree.light,
          onPressed:(){
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        });
      }, child:Row(mainAxisSize: MainAxisSize.min,
          children:[
        Icon(Icons.search,color:Colors.black),
        Text('Tìm khách hàng',style:TextStyle(color:Colors.black))
      ])),
      SizedBox(height:10),
      AnimatedButton(
          color: Colors.grey,
          shadowDegree: ShadowDegree.light,
          onPressed:(){
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GetData()),
          );
        });
      }, child: Text('Check In',style:TextStyle(color:Colors.black))),
      SizedBox(height:10),
      AnimatedButton(
          color: Colors.grey,
          shadowDegree: ShadowDegree.light,
          onPressed:(){
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCheckOut()),
              );
            });
          }, child: Text('Check Out',style:TextStyle(color:Colors.black))),
      SizedBox(height:10),
      AnimatedButton(
          color: Colors.grey,
          shadowDegree: ShadowDegree.light,
          onPressed:(){
            setState(() {
              insertthe();
            });
          }, child: Text('Thêm thẻ',style:TextStyle(color:Colors.black))),
      SizedBox(height:10),
      AnimatedButton(
          color: Colors.grey,
          shadowDegree: ShadowDegree.light,
          onPressed:(){
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => App()),
              );
            });
          }, child: Text('Check Out',style:TextStyle(color:Colors.black))),
    ]);
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(

        appBar: AppBar(title: const Text('Giữ xe')),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(child:
          Center(child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                if(checksecondtime==false)
                accountcheck(),
                if(checksecondtime==false)
                passwordcheck(),
                if(checksecondtime==false)
                NextBTN(),
                if(checksecondtime==true)functionlist(),
              ]
          )));
        }));
  }
}
