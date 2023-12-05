import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:smart_sun/services/storage_services.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_sun/Models/Appliance.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color Yellow = Color(0xFFF3BA2F);
  final Color Black = Color(0xFF000000);
  final Color LightYellow = Color(0xFFFFD54F);
  @override
  void initState() {
    super.initState();
    switchStates = List.generate(appliancesList.length, (index) => false);
    // _getOnLoad();
  }

  final address = dotenv.env['SERVER_ADDRESS'];
  late String system_id;
  String TOKEN = '';
  num ccv = 0;
  num pcv = 0;
  // bool is_on = false;
  bool is_fetching = true;
  List<bool> switchStates = []; 
  List<String> appliancesList = ['DishWasher', 'Heater', 'AC', 'Item4', 'Item5', 'Item6', 'Item7'];
  // var appliancesList = [];

//   _getOnLoad() async {
//     await _getToken();
//     await _getHomeReadings();
//     await _getAppliances();
//   }

//   _getAppliances() async {
//     final response = await http.post(
//       Uri.parse('$address/user/system'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'system_id': system_id,
//       }),
//     );
//     if (response.statusCode == 200) {
//       var system = await jsonDecode(response.body);

//       var appliances = await system['appliances'];

//       print(appliances[0]['name']);

//       setState(() {
//         appliancesList = appliances;
//       });
//       setState(() {
//         is_fetching = false;
//       });
//     } else {
//       print('not called');
//     }
//   }

//   _getInfoFromJwt(TOKEN) async {
//     Map<String, dynamic> payload = await Jwt.parseJwt(TOKEN);
//     setState(() {
//       system_id = payload['system_id'];
//     });
//     print(system_id);
//   }

//   _getHomeReadings() async {
//     final response = await http.post(
//       Uri.parse('$address/user/reading'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'system_id': system_id,
//       }),
//     );
//     if (response.statusCode == 200) {
//       var readings = await jsonDecode(response.body);
//       ccv = readings['current_consumption'];
//       pcv = readings['possible_consumption'];
//       setState(() {
//         pcv = pcv.roundToDouble();
//         ccv = ccv.roundToDouble();
//       });
//       print('Called successfully');
//     } else {
//       print('not called');
//     }
//   }

//   _getToken() async {
//     var token = await SharedPrefUtils.readPrefStr('TOKEN');
//     setState(() {
//       TOKEN = token;
//     });
//     await _getInfoFromJwt(TOKEN);
//     print(token);
//   }

//switch controllers
  _turnOn(index) async {
    // final response = await http
    //     .get(Uri.parse('$address/user/switch/on'), headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // });
    // if (response.statusCode == 200) {
    //   print(response.body);
      setState(() {
        // is_on = true;
        switchStates[index] = true;
      });
    // }
  }

  _turnOff(index) async {
    // final response = await http
    //     .get(Uri.parse('$address/user/switch/off'), headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // });
    // if (response.statusCode == 200) {
    //   print(response.body);
      setState(() {
        // is_on = false;
        switchStates[index] = false;
      });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // if (is_fetching == false) {
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
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('My Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          color: Yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 33.0,
                        )),
                    SizedBox(width: 10),
                    Icon(
                      Icons.home,
                      color: Yellow,
                      size: 35,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                    child: Text(
                  'Tap on the values to update',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Yellow,
                  ),
                )),
                SizedBox(height: 20),
                GestureDetector(
                  // onTap: () {
                  //   _getHomeReadings();
                  // },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Column(
                        children: <Widget>[
                          Text('Current Consumption',
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  color: Yellow,
                                  fontSize: 12.0)),
                          Container(
                            height: 80.0,
                            width: 125.0,
                            child: Material(
                              color: Yellow,
                              borderRadius: BorderRadius.circular(15),
                              child: Center(
                                child: Text(
                                  '$ccv A',
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(width: 50.0),
                      Container(
                          child: Column(
                        children: <Widget>[
                          Text('Possible Consumption',
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  color: Yellow,
                                  fontSize: 12.0)),
                          Container(
                            height: 80.0,
                            width: 125.0,
                            child: Material(
                              color: Yellow,
                              borderRadius: BorderRadius.circular(15),
                              child: Center(
                                child: Text(
                                  '$pcv A',
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Controller Box',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 33.0,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 340.0,
                  child: Material(
                    color: Yellow,
                    borderRadius: BorderRadius.circular(15),
                    child: ListView.builder(
                      itemBuilder: (
                        BuildContext,
                        index,
                      ) {
                        return Card(
                          color: Yellow,
                          child: SwitchListTile(
                            title: Text(
                              // '${appliancesList[index]['name']}',
                              '${appliancesList[index]}',
                              style: TextStyle(
                                  fontFamily: 'Oswald',
                                  color: Black,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: switchStates[index],
                            // onChanged: (value) => {
                            //   if (is_on == true)
                            //     {
                            //       _turnOff(),
                            //     }
                            //   else
                            //     {
                            //       _turnOn(),
                            //     }
                            // },
                            onChanged: (value) {
                              setState(() {
                                switchStates[index] = value;
                              });
                              if (value) {
                                _turnOn(index);
                              } else {
                                _turnOff(index);
                              }
                            },
                            activeColor: Yellow, // Change this to your desired active color
                            activeTrackColor: Black, // Change this to your desired active track color
                            inactiveThumbColor: Black, // Change this to your desired inactive thumb color
                            inactiveTrackColor: Yellow,
                            trackOutlineColor: MaterialStateProperty.resolveWith(
                              (final Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return null;
                                }

                                return Black;
                              },
                            ),
                          ),
                        );
                      },
                      itemCount: appliancesList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15),
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // }
    // else {
    //   return (CircularProgressIndicator.adaptive());
    // }
  }
}
