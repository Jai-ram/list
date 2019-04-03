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
  Widget getListView(){
    return new ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount: data==null ? 0 : data.length,
      itemBuilder: (BuildContext context, i){
        return new ListTile(
          title: new Text(data[i]["name"]),
          subtitle: new Text(
            (data[i]["title"]!=null) ? data[i]["title"].toString().toUpperCase() : "UNKNOWN"
          ),
          leading: new CircleAvatar(
            backgroundImage: new NetworkImage(getPhotoURL(data[i]["squareImage"])),),
          trailing: getEmoji(data[i]["position"]),
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
    );
  }
@override
Widget build(BuildContext context){
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Billionaire's List")
      ),
    body: data == null ? Center(child: CircularProgressIndicator(),) : getListView()
  );
}
Widget getEmoji(int i){
  switch(i){
    case 1:
      return Text("🥇",style: TextStyle(fontSize: 30),);
    case 2:
      return Text("🥈",style: TextStyle(fontSize: 30),);
    case 3:
      return Text("🥉",style: TextStyle(fontSize: 30),);
    default:
      return Text(i.toString(),style: TextStyle(color: Colors.purple, fontSize: 30),);
  }
}
  String getPhotoURL(String s){
    if(s!=null){
      return "https:"+s;
    }else{
      return "https://specials-images.forbesimg.com/imageserve/5ab944eda7ea432fbc1d2d9c/416x416.jpg?background=000000&cropX1=0&cropX2=400&cropY1=0&cropY2=400";
    }
  }
}

class SecondPage extends StatelessWidget{
  SecondPage(this.data);
  final data;

  String getSource(){
    var source = data['source']!= null ? data['source'] +',\n' : "";
    var state = data['state']!= null ? data['state']  +',\n': "";
    var country = data['country']!= null ? data['country'] +'.' : "";
    return (source + state  + country);
  }

  Widget getSourceWidget(){
    return new Row(
      children: <Widget>[
      new SizedBox(width: 70,),
      new Text('Source:',style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
      new SizedBox(width: 50,),
      new Text(getSource(),style: TextStyle(color: Colors.green, fontSize: 20)),
    ],);
  }

  Widget getIndustryWidget(){
    return new Row(
      children: <Widget>[
      new SizedBox(width: 60,),
      new Text('Industry:',style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
      new SizedBox(width: 50,),
      new Text(data['industry'],style: TextStyle(color: Colors.green, fontSize: 20))
    ],);
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text(data['name']) 
    ),
    body: new Center(
      child: new Column(
        children: [
          new SizedBox(height: 30,), 
          new Container(
            width: 200.0,
            height: 200.0,
            decoration: new BoxDecoration(
              color: const Color(0xff),
              image: new DecorationImage(
                image: new NetworkImage("https:"+data["squareImage"]),
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
              border: new Border.all(
                color: Colors.lightBlueAccent,
                width: 4.0
              )
            ),
          ),
          new SizedBox(height: 30,),
          new Text(data['name']+'  ('+data['age'].toString()+')',style: TextStyle(color: Colors.green, fontSize: 30), textAlign: TextAlign.center,),
          new SizedBox(height: 10,),
          new Text((data["title"]!=null) ? data["title"].toString().toUpperCase() : "",style: TextStyle(color: Colors.blueGrey, fontSize: 20),textAlign: TextAlign.center,),
          new SizedBox(height: 10,),
          new Text('💵' + (data['worth']/1000).toString() + 'B',style: TextStyle(color: Colors.green[800], fontSize: 25),textAlign: TextAlign.center,),
          new SizedBox(height: 10,),
          getSourceWidget(),
          new SizedBox(height: 10,),
          getIndustryWidget()
        ]
      )
    ),
  );
}