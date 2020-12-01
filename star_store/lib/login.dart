import 'package:flutter/material.dart';
import 'main.dart';

class Login extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {


    final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    try {
      email.clear();
      password.clear();
    } catch (_) {}
  }


    return Scaffold(
        
        appBar: AppBar(
          title: 
          Text("Login"),
          centerTitle: true,
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
                  obscureText: true,
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
                            getAll(email.text, password.text);
                            if (cred == true) {
                              Navigator.pushNamed(context, '/homepage');
                            } else {
                              print('false');
                            };
                  }),
              ),
        
              Padding(
                padding: EdgeInsets.only(left:0, bottom: 40),
                child: GestureDetector(
                  onTap: ()=> Navigator.pushNamed(context, '/register'),
                  child: Text('Sign Up'
                  ,style: TextStyle(
                    fontSize: 15
                    ,fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                  ),
                ), 
                )
            ],
          ),
        )));
  }
}