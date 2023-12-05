import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_sun/pages/login.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = '/register';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Color Yellow = Color(0xFFF3BA2F);
  final Color Black = Color(0xFF000000);
  final Color LightYellow = Color(0xFFEBB435);
  late String _userName;
  late String _phoneNumber;
  late String _systemId;
  late String _password;
  late String _email;
  final address = dotenv.env['SERVER_ADDRESS'];
  _register() async {
    final response = await http.post(
      Uri.parse('$address/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': '$_userName',
        'email': '$_email',
        'phone': '$_phoneNumber',
        'system_id': '$_systemId',
        'password': '$_password'
      }),
    );
    if (response.statusCode == 200) {
      print('success');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      throw Exception('Failed to create user.');
    }
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
                  height: 30.0,
                ),
                Text('Welcome',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    )),
                Text('Few clicks to control \n your house',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    )),
                SizedBox(height: 17.5),
                Container(
                  height: 490.0,
                  child: Material(
                    color: Yellow,
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 12.0,
                        ),
                        Text('REGISTER',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            )),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                            height: 4.0,
                            width: 150,
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              color: Black,
                            )),
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: TextField(
                            cursorColor: Black,
                            onChanged: (value) => setState(() {
                              _userName = value;
                            }),
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              height: 0.5,
                              color: Black,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              filled: true,
                              fillColor: LightYellow,
                              border: OutlineInputBorder(),
                              hintText: 'Username',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
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
                              height: 0.5,
                              color: Black,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              filled: true,
                              fillColor: LightYellow,
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: TextField(
                            cursorColor: Black,
                            onChanged: (value) => setState(() {
                              _phoneNumber = value;
                            }),
                            style: TextStyle(
                              fontFamily:'Oswald',
                              height: 0.5,
                              color: Black,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              filled: true,
                              fillColor: LightYellow,
                              border: OutlineInputBorder(),
                              hintText: 'Phone Number',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: TextField(
                            cursorColor: Black,
                            onChanged: (value) => setState(() {
                              _systemId = value;
                            }),
                            style: TextStyle(
                              fontFamily:'Oswald',
                              height: 0.5,
                              color: Black,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              filled: true,
                              fillColor: LightYellow,
                              border: OutlineInputBorder(),
                              hintText: 'System Id',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
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
                              height: 0.5,
                              color: Black,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 2.0,
                                color: Black,
                              )),
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
                              _register();
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              color: Black,
                              child: Center(
                                child: Text(
                                  'Register',
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
                          height: 12.0,
                        ),
                        Center(
                            child: Text(
                          " Already have an acoount ?",
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
                                    builder: (context) => LoginPage()));
                          },
                          child: Text('Login',
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
