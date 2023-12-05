import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Color Yellow = Color(0xFFF3BA2F);
  final Color Grey = Color(0xFFC0C0C0).withOpacity(0.30);
  final Color Black = Color(0xFF000000);
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
            padding: EdgeInsets.only(left: 0, right: 0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Notifications',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily:'Oswald',
                        color: Yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 33.0,
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: Yellow,
                      size: 35,
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 50,
                  color: Yellow,
                  child: Center(
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontFamily:'Oswald',
                          color: Black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
