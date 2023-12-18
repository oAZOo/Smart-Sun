// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_sun/pages/navbar.dart';
import 'package:smart_sun/pages/register.dart';
// import 'package:http/http.dart' as http;
// import 'package:smart_sun/services/storage_services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Color Yellow =  Color(0xFFF3BA2F);
  final Color Black = Color(0xFF000000);
  final Color LightYellow = Color(0xFFEBB435);

  @override
  late String _password;
  late String _email;
  final address = dotenv.env['SERVER_ADDRESS'];

  _login() async {
    // final response = await http.post(
    //   Uri.parse('$address/login'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(
    //       <String, String>{'email': '$_email', 'password': '$_password'}),
    // );

    // if (response.statusCode == 200) {
    //   var userSystem = await jsonDecode(response.body);

    //   var system = userSystem['system'];
    //   List appliances = system['appliances'];

    //   await SharedPrefUtils.saveStr('TOKEN', userSystem['token']);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NavBar()),
      );
    // } else {
    //   throw Exception('wrong credentials');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/background.png'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  'Smart Sun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Yellow,
                    fontFamily:'Oswald',
                    fontWeight: FontWeight.bold,
                    fontSize: 33.0,
                  ),
                ),
                Text(
                  'Controller',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Yellow,
                    fontFamily:'Oswald',
                    fontWeight: FontWeight.bold,
                    fontSize: 33.0,
                  ),
                ),
                SizedBox(height: 60.0),
                Container(
                  height: 365.0,
                  child: Material(
                    color: Yellow,
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily:'Oswald',
                            color: Black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Container(
                          height: 4.0,
                          width: 150,
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            color: Black,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: TextField(
                            cursorColor: Black,
                            onChanged: (value) => setState(() {
                              _email = value;
                            }),
                            style: TextStyle(
                              fontFamily:'Oswald',
                              color: Black,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Black,
                                ),
                              ),
                              filled: true,
                              fillColor: LightYellow,
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: TextField(
                            cursorColor: Black,
                            onChanged: (value) => setState(() {
                              _password = value;
                            }),
                            style: TextStyle(
                              fontFamily:'Oswald',
                              color: Black,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Black,
                                ),
                              ),
                              filled: true,
                              fillColor: LightYellow,
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                            ),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: 278,
                          height: 50,
                          child: GestureDetector(
                            onTap: () {
                              _login(); 
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              color: Black,
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily:'Oswald',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Yellow,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                            child: Text(
                          " Don't have an account ?",
                                  style: TextStyle(
                                    fontFamily:'Oswald'
                                  ),
                        )),
                        SizedBox(
                          height: 5.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text('CREATE',
                              style: TextStyle(
                                  fontFamily:'Oswald',
                                  color: Black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
