import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Sellers extends StatefulWidget {
  @override
  _SellersState createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
 
Future<EmployeeData> fetchData(index) async {
  final response = await http.get('https://reqres.in/api/users');

  if (response.statusCode == 200) {
   
    return EmployeeData.fromJson(jsonDecode(response.body),index);
  } else {
  
    throw Exception('Failed to load EmployeeData');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: 
     ListView.builder(itemBuilder: (BuildContext context,int index){
       return  FutureBuilder<EmployeeData>(
            future: fetchData(index),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return 
                
                
                Container(width: 50,height:200,child: Card(child: Column(children: [
                  Image.network(snapshot.data.avatar),
                  Text('ID: '+snapshot.data.id.toString()),
                  Text(snapshot.data.name),
                  Text(snapshot.data.email)
                ],),),);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
            return CircularProgressIndicator();
              
            },
          );
           
        
     },
  itemCount: 5,     ) 
    ),) 
    ;
  }
}
class EmployeeData {
  final int id;
  final String email;
  final String name;
  final String avatar;
  EmployeeData({this.id,this.email,this.name,this.avatar});
  factory EmployeeData.fromJson(Map<String, dynamic> json, int index) {
    return EmployeeData(
      id: json['data'][index]['id'],
      name: json['data'][index]['first_name']+ ' ' + json['data'][index]['last_name'],
      email: json['data'][index]['email'],
      avatar: json['data'][index]['avatar']
    );
  }
}