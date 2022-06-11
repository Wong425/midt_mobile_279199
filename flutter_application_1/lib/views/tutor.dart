import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/suc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../constants.dart';
import '../modal/tutor.dart';
import 'fav.dart';

void main() => runApp(TutorScreen());

class TutorScreen extends StatefulWidget {
  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  int index = 0;
  final screens = [
    TutorScreen(),
    TutorScreen(),
    SubscirbeScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];
  List<Tutor> tutorList = <Tutor>[];
  String titlecenter = "Loading...";
  var numofpage, curpage = 1;
  var color;
  late double screenHeight, screenWidth, resWidth;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadProducts(1, "All");
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor'),
    
      ),
      // body: 
      // // body: IndexedStack(index: index, children: screens,),
      // screens[index],
      // bottomNavigationBar: NavigationBarTheme(
      //     data: NavigationBarThemeData(
      //       indicatorColor: Colors.amber.shade100,
      //     ),
      //     child: NavigationBar(
      //       backgroundColor: Colors.yellow,
      //       onDestinationSelected: (index) =>
      //           setState(() => this.index = index),
      //       selectedIndex: index,
      //       animationDuration: Duration(seconds: 3),
      //       destinations: [
      //         NavigationDestination(icon: Icon(Icons.book), label: 'Subject'),
      //         NavigationDestination(icon: Icon(Icons.person), label: 'Tutors'),
      //         NavigationDestination(
      //             icon: Icon(Icons.bookmark), label: 'Subscirbe'),
      //         NavigationDestination(
      //             icon: Icon(Icons.favorite), label: 'Favourite'),
      //         NavigationDestination(
      //             icon: Icon(Icons.account_box), label: 'Profile'),
      //       ],
      //     )),
        //  body:subList.isEmpty
        //   ? Padding(
        //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        //       child: Column(
        //         children: [
        //           Center(
        //               child: Text(titlecenter,
        //                   style: const TextStyle(
        //                       fontSize: 18, fontWeight: FontWeight.bold))),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: types.map((String char) {
                  //       return Padding(
                  //         padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  //         child: ElevatedButton(
                  //           child: Text(char),
                  //           onPressed: () {
                  //             _loadProducts(1, char);
                  //           },
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
            //     ],
            //   ),
            // )
          
           body: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                      children: List.generate(tutorList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/midt_mobile_279199/lutter_application_1/assets/tutor/" +
                                      tutorList[index].tutor_id.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Text(
                                tutorList[index].tutor_name.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              
                            ],
                          )),
                        );
                      }))),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.red;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () =>
                              {_loadProducts(index + 1,"All")},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _loadProducts(int pageno,String _type) {
    curpage = pageno;
    numofpage ?? 1;
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: 'Loading...', max: 100);
    http.post(

        Uri.parse(CONSTANTS.server + "/mt_mobile/user/php/tutor.php"),
        body: {
          'pageno': pageno.toString(),
          'type': _type,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        titlecenter = "Timeout Please retry again later";
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);
        if (extractdata['tutor'] != null) {
          tutorList = <Tutor>[];
          extractdata['Tutor'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
          titlecenter = tutorList.length.toString() + " Tutor Available";
        } else {
          titlecenter = "No Tutor Available";
          tutorList.clear();
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Tutor Available";
        tutorList.clear();
        setState(() {});
      }
    });
    pd.close();
  }
}
