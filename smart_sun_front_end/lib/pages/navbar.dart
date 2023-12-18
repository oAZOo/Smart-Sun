import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_sun/pages/home.dart';
import 'package:smart_sun/pages/profile.dart';
import 'package:smart_sun/pages/notification.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  static const routeName = '/navbar';

  @override
  State<NavBar> createState() => _NavBarState();
}

final Color Yellow = Color(0xFFF3BA2F);
final Color Grey = Color(0xFFC0C0C0).withOpacity(0.30);
final Color Black = Color(0xFF000000);

class _NavBarState extends State<NavBar> {
  int index = 1;

  final screens = [
    NotificationPage(),
    HomePage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.notifications, size: 30.0),
      Icon(Icons.home, size: 30.0),
      Icon(Icons.person, size: 30.0)
    ];

    return Scaffold(
      backgroundColor: Black,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: Theme(
        data:
            Theme.of(context).copyWith(iconTheme: IconThemeData(color: Black)),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Yellow,
          height: 60.0,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          index: index,
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
