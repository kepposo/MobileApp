import 'package:flutter/material.dart';

class Login extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/logo/logoBlue.png', height: 200,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    //border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(),
                  ),
                ),
               
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
                child: MaterialButton(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:200, bottom: 50),
                child: GestureDetector(
                  onTap: ()=> Navigator.pushNamed(context, '/register'),
                  child: Text('''SignUp'''
                  ,style: TextStyle(
                    fontSize: 20
                    ,fontWeight: FontWeight.bold
                  ),
                  ),
                ), 
                )
            ],
          ),
        )));
  }
}