import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
class MyCheckOut extends StatefulWidget {
  @override
  _MyCheckInState createState() => _MyCheckInState();
}
class _MyCheckInState extends State<MyCheckOut> {
  String _scanBarcode = 'chưa biết';
  String ngaygiolayxe="00/00/0000";
  String thexe="-1";
  String hoatdongthe="0";
  @override
  void initState() {
    super.initState();
  }
  FutureOr<String> fetchdata(String mathe) async {

    final response = await http.get(Uri.parse('http://192.168.1.12//CarParkAPI/index.php?thexe=$mathe&nhanvien=$username'));


    if (response.statusCode == 200) {
      String data=response.body;
      setState(() {
        ngaygiolayxe = json.decode(data)["ngaygiolayxe"].toString();
        thexe =json.decode(data)["thexe"].toString();
        hoatdongthe=json.decode(data)["hoatdongthe"].toString();
      });
      throw Exception('nhận được tín hiệu');



      // return parseProducts(response.body);
    } else {

      throw Exception('Không nhận được tín hiệu');

    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'không nhận diện được mã QR';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      fetchdata(_scanBarcode);
    });
  }


  @override
  Widget build(BuildContext context) {


    return  Scaffold(

        appBar: AppBar(title:  Text(username)),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(child:
          Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            fetchdata(0.toString());
                            // scanQR();
                          });
                        },
                        child: Text('Quét mã QR của thẻ')),
                    SizedBox(height:20),
                    Text('mã thẻ: $thexe',style: TextStyle(fontSize: 30),),
                    if(int.parse(hoatdongthe)==1)
                      Text('tình trạng thẻ: HOẠT ĐỘNG',style: TextStyle(fontSize: 30, color:Colors.green),),
                    if(int.parse(hoatdongthe)==0)
                      Text('tình trạng thẻ: VÔ HIỆU',style: TextStyle(fontSize: 30,color: Colors.red),),
                    SizedBox(height:20),
                    Text("ngày/giờ: $ngaygiolayxe",style: TextStyle(fontSize: 15),),
                    SizedBox(height:20),


                  ])));
        }));
  }
}
