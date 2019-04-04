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
      title: new Text('Billionares')
      ),
    body: new ListView.builder(
      itemCount: data==null?0:data.length,
      itemBuilder: (BuildContext context, i){
        return new ListTile(
          title: new Text(data[i]["name"]),
          subtitle: new Text(
            (data[i]["title"]!=null) ? data[i]["title"].toString().toUpperCase() : "UNKNOWN"
          ),
          leading: new CircleAvatar(
          backgroundImage: new NetworkImage(getPhotoURL(data[i]["squareImage"])),),
          trailing: new Text(data[i]["position"].toString()),
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
            
              String getPhotoURL(String s) {
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
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text(data['name']) 
    ),
    body:  Center(
      child: Column(
      children:<Widget>[
        
        
      new Container(
        width: 150.0,
        height: 150.0,
        
              
        decoration: new BoxDecoration(
          color: const Color(0xff),
          image: new DecorationImage(
            image: new NetworkImage(getPhotoURL(data["squareImage"])),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(new Radius.circular(75.0)),
                      border: new Border.all(
                        color: Colors.lightBlueAccent,
                        width: 4.0
                      )
                    ),
                    
                  ),
                
                  Row( children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0,top:5.0),
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             Text("Name:"+data["name"], style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                   Row(children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             Text((data["position"]!=null) ? "Position:"+data["position"].toString():"Position:"+"Unknown", style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                   Row(children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             Text((data["title"]!=null) ? "Title:"+data["title"]:"Title:"+"Unknown", style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                   Row(children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             Text((data["gender"]=="M") ? "Gender:Male":"Gender:Female", style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                   Row(children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                        
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             Text((data["age"]!=null) ? "Age:"+data["age"].toString():"Age:"+"Unknown", style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                   Row(children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Text((data["country"]!=null) ? "Country:"+data["country"]:"Country:"+"Unknown", style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                   Row(children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                                Text((data["worth"]!=null) ? "Worth:"+data["worth"].toString()+"B \$":"Worth:"+"Unknown", style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                   Row(children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Text((data["source"]!=null) ? "Source:"+data["source"].toString():"Source:"+"Unknown", style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                   Row(children: <Widget>[
                    new Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                      child: new Container(
                        height:30.0 ,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Text((data["industry"]!=null) ? "Industry:"+data["industry"]:"Industry:"+"Unknown", style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                    )
                  ],),
                  
                 
                  
                  
                  
                 
                
              
                
                 
                  

      ]
                ),
    )
              );
            
             String getPhotoURL(String s) {
                 if(s!=null){
                    return "https:"+s;
                      }else{
                       return "https://specials-images.forbesimg.com/imageserve/5ab944eda7ea432fbc1d2d9c/416x416.jpg?background=000000&cropX1=0&cropX2=400&cropY1=0&cropY2=400";
                               }
                  
              }
}