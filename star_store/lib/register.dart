import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math' as math;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

enum Gender { male, female }

class _SignUpState extends State<SignUp> {
  Gender _gender = Gender.male;

  bool status = false;

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  bool valuefirst = false;
  bool valuesecond = false;

  @override
  void dispose() {
    try {
      name.clear();
      email.clear();
      password.clear();
      password2.clear();
      super.dispose();
    } catch (_) {}
  }

  bool nameCheck(String name) {
    int len = name.length;
    if (len < 3) {
      return false;
    }
    for (int i = 0; i <= len - 1; ++i) {
      if (int.tryParse(name[i]) == null) {
        print('true');
        return true;
      }
    }
    return false;
  }

  dynamic validation(
      String name, String email, String password1, String password2) {
    String pass = password1;
    List error = new List();
    print('Validating...');
    print(email + name);
    String match = password1 != password2 || password1.isEmpty
        ? 'Passwords do not match or empty'
        : 'Valid';
    String passLength =
        password1.length < 6 ? 'Password is too short' : 'Valid';
    String validEmail =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(email)
            ? 'Valid'
            : 'Email is invalid';
    String validName = nameCheck(name)
        ? 'Valid'
        : 'Name Must not conatin numbers and consist of 3 or more letters';
    List errors = [match, passLength, validName, validEmail];

    for (String err in errors) {
      if (err != 'Valid') {
        error.add(err);
      }
    }

    if (error.length > 0) {
      print('Validation Error');
      print(error);
      return validationMsg(error);
    } else {
      print('Validation complete');
      dispose();
      Navigator.of(context).pop();
      return reg(name.toString(), email.toString(), pass.toString());
    }
  }

  void reg(name, email, password) {
    var user = User(name: name, email: email, password: password);
    insertUsers(user);
  }

  dynamic validationMsg(List errors) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            scrollable: true,
            title: Text('Validation Error'),
            content: Container(
              width: 100,
              height: 300,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    selected: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    // leading: Icon(Icons.circle),
                    title: Text(
                      errors[index],
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      '________________________________',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                itemCount: errors.length,
              ),
            ),
            actions: [
              RaisedButton(
                child: Icon(Icons.arrow_right),
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

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
                  controller: email,
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
                  controller: name,
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
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: password,
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
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: password2,
                    decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Confirm Password',
                    
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
                      child:  MaterialButton(
                            child: Text("Register", style: TextStyle(color: Colors.white),),
                            color: Colors.blue,
                            onPressed: () => validation(name.text, email.text,
                                password.text, password2.text)
                            ),
                      ),
               ],
          ),
        )));
  }
}
