import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:giuxe/info.dart';
import 'package:giuxe/search.dart';
import 'package:giuxe/sqlite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatefulWidget {
  @override
  MyResult createState() => MyResult();
}
var id;
var time;
var children;
class MyResult  extends State<ResultPage>{
  void Loadimage1() async{
    SharedPreferences saveimage=await SharedPreferences.getInstance();
    setState(() {
      hinhxe=saveimage.getString("hinhxe"+id.toString()+time.toString());
    });

  }
  void Loadimage2() async{
    SharedPreferences saveimage=await SharedPreferences.getInstance();
    setState(() {
      hinhbienso=saveimage.getString("hinhbienso"+id.toString()+time.toString());
    });

  }
  Widget body(){
    return FutureBuilder<List<danhsach>>(
      future:getdatawithdate(),
      builder:(BuildContext context, AsyncSnapshot<List<danhsach>> snapshot){

      if (snapshot.hasData) {
        children = ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: newmaps.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children:[
                if(index==0)ElevatedButton(onPressed:(){}, child: Text('xóa toàn bộ')),
                ElevatedButton(
                    onPressed:(){
                      setState(() {
                        id=newmaps[index]['id'].toString();
                        time=newmaps[index]['time'].toString();
                        Loadimage1();
                        Loadimage2();
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetInfo()),
                      );
                    },
                    child: Center(child: Column(children:[
                      Text('id: '+newmaps[index]['id'].toString()+', mã thẻ: ' +newmaps[index]['mathe'].toString()),
                      Text('thời gian :'+ newmaps[index]['time'].toString())
                    ]),
                    )
                ),
                SizedBox(height:10),

              ]);
            }
        );
      } else if (snapshot.hasError) {
        children = Column(children:[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: ${snapshot.error}'),
          )
        ]);
      } else {
        children = Column(children:[
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
          )
        ]);
      }
      return Center(
        child: children,
      );
    }

    );
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(

        appBar: AppBar(title: const Text('Giữ xe')),
        body: Builder(builder: (BuildContext context) {

            return body();

        }));
  }
}