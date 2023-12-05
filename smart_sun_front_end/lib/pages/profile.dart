import 'package:flutter/material.dart';
import 'package:smart_sun/pages/login.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../services/storage_services.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Color Yellow =  Color(0xFFF3BA2F);
  final Color Black = Color(0xFF000000);
  final Color LightYellow = Color(0xFFFFD54F);
  @override
  void initState() {
    getToken();
    super.initState();
  }

  var username = '';
  var email = '';
  var system_id = '';
  var system_name = '';

  getToken() async {
    var token = await SharedPrefUtils.readPrefStr('TOKEN');
    String TOKEN = token;
    print('this is the token baby $TOKEN');
    await getInfoFromJwt(TOKEN);
  }

  getInfoFromJwt(TOKEN) async {
    Map<String, dynamic> payload = await Jwt.parseJwt(TOKEN);
    setState(() {
      username = payload['username'];
      email = payload['email'];
      system_id = payload['system_id'];
      // system_name = payload['name'];
      print(payload);
    });
  }

  
  _logout() async {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/background.png',
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily:'Oswald',
                        color: Yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 33.0,
                      ),
                    ),
                    Icon(
                      Icons.person,
                      color: Yellow,
                      size: 35,
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      // '$username',
                      'Gio',
                      style: TextStyle(
                        fontFamily:'Oswald',
                        color: Black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 50.0,
                  color: Yellow,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Center(
                    child: Text(
                      // 'Email: $email',
                      'Email: giovanni.azar@gmail.com',
                      style: TextStyle(
                        fontFamily:'Oswald',
                        color: Black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 50.0,
                  color: Yellow,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: Text(
                      // 'System NAme: $system_name',
                      'System Name: Gios Home',
                      style: TextStyle(
                        fontFamily:'Oswald',
                        color: Black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 50.0,
                  color: Yellow,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: Text(
                      // 'System Id: $system_id',
                      'System Id: 52FX964SFX',
                      style: TextStyle(
                        fontFamily:'Oswald',
                        color: Black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 50.0,
                  color: Yellow,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: Text(
                      // 'System NAme: $system_name',
                      'Power Rating: 3300 W',
                      style: TextStyle(
                        fontFamily:'Oswald',
                        color: Black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height: 50.0,
                  color: Yellow,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                          width: 278,
                          height: 50,
                          child: GestureDetector(
                            onTap: () {
                              _logout();
                            },
                            child: Material(
                              color: Yellow,
                              child: Center(
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontFamily:'Oswald',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Black,
                                  ),
                                ),
                              ),
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
