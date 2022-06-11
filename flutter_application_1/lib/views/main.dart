import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/sub.dart';
import 'package:flutter_application_1/views/suc.dart';
import 'package:flutter_application_1/views/tutor.dart';
import 'fav.dart';

class MainScreen extends StatefulWidget {
  // final Customer customer;
  // const MainScreen({
  //   Key? key,
  //   required this.customer,
  // }) : super(key: key);
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final screens = [
    SubScreen(),
    TutorScreen(),
    SubscirbeScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Tutor'),
        ),
                body: screens[index],
        // body: screens[index],
        // body: IndexedStack(index: index, children: screens,),
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.amber.shade100,
            ),
            child: NavigationBar(
              backgroundColor: Colors.yellow,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              selectedIndex: index,
              animationDuration: Duration(seconds: 3),
              destinations: [
                NavigationDestination(icon: Icon(Icons.book), label: 'Subject'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Tutors'),
                NavigationDestination(
                    icon: Icon(Icons.bookmark), label: 'Subscirbe'),
                NavigationDestination(
                    icon: Icon(Icons.favorite), label: 'Favourite'),
                NavigationDestination(
                    icon: Icon(Icons.account_box), label: 'Profile'),
              ],
 
            )));
  }

  // Widget _createDrawerItem(
  //     {required IconData icon,
  //     required String text,
  //     required GestureTapCallback onTap}) {
  //   return ListTile(
  //     title: Row(
  //       children: <Widget>[
  //         Icon(icon),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 8.0),
  //           child: Text(text),
  //         )
  //       ],
  //     ),
  //     onTap: onTap,
  //   );
  // }
}
