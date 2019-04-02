import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() => runApp(new MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://forbes400.herokuapp.com/api/forbes400/"),
      headers: {
        "Accept": "application/json"
      }
    );

    this.setState(() {
      data = json.decode(response.body);
    });
   
    
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
@override
Widget build(BuildContext context){
  return new Scaffold(
    appBar: new AppBar(
      title: new Text('List')
      ),
    body: new ListView.builder(
      itemCount: data==null?0:data.length,
      itemBuilder: (BuildContext context, i){
        return new ListTile(
          title: new Text(data[i]["name"]),
          subtitle: new Text(data[i]["source"]),
          
          //leading: new CircleAvatar(
            //backgroundImage: new NetworkImage(data[i]["squareImage"]),),
          onTap: (){
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (BuildContext context) =>
                new SecondPage(data[i]))
              );
            

          },
        );
      }
    )
  );
}
}

class SecondPage extends StatelessWidget{
  SecondPage(this.data);
  final data;
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('Image') 
    ),
    body: new Center(
      child: new Container(
        width: 1200.0,
        height: 1200.0,
        decoration: new BoxDecoration(
          color: const Color(0xff),
          image: new DecorationImage(
            image: new NetworkImage(data["squareImage"]),
            fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(600.0)),
          border: new Border.all(
            color: Colors.lightBlueAccent,
            width: 4.0
          )
        ),
      ),
    ),
  );
}