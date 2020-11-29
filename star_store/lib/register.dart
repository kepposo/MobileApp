import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

enum Gender { male, female }

class _SignUpState extends State<SignUp> {
  Gender _gender = Gender.male;

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/logo/logoBlue.png',
                height: 200,
              ),
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
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(),
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
              ListTile(
                title: const Text('Male'),
                leading: Radio(
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Female'),
                leading: Radio(
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value;
                      });
                    },
                    activeTrackColor: Colors.blue,
                    activeColor: Colors.blue,
                  ),
                  Text("Do you accept our terms and conditions?", style: TextStyle(color: Colors.grey),),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
                child: MaterialButton(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )));
  }
}
