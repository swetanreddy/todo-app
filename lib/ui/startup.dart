import 'package:flutter/material.dart';
import 'package:todo/ui/CreateTask.dart';
import 'package:todo/ui/HomePage.dart';
import 'package:todo/ui/ProfilePage.dart';
import 'package:todo/helpers/theme.dart';

import 'tasksfilterPersonal/personalDoneTasks.dart';

class startUpPage extends StatefulWidget {
  const startUpPage({Key? key}) : super(key: key);

  @override
  State<startUpPage> createState() => _startUpPageState();
}

class _startUpPageState extends State<startUpPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    doneTasksPersonal(taskFilter: 'personalDone'),
    ProfilePage(),
     ProfilePage(),
  
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECF0F3),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        foregroundColor: Colors.white,
        backgroundColor: primary,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateTask(),
          ));
        },
        child: const Icon(Icons.add, size: 25),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    final w = MediaQuery.of(context).size.width;
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // MaterialButton(
                //   minWidth: 40,
                //   onPressed: () {
                //     // setState(() {
                //     //   currentScreen =
                //     //       Dashboard(); // if user taps on this dashboard tab will be active
                //     //   _selectedIndex = 0;
                //     // });
                //   },
                //   child: Container(
                //     height: 60,
                //     width: MediaQuery.of(context).size.width / 5,
                //     decoration: _selectedIndex == _selectedIndex
                //         ? BoxDecoration(
                //             border: Border(
                //               bottom: BorderSide(width: 4, color: primary),
                //             ),
                //             gradient: LinearGradient(
                //                 colors: [
                //                   Colors.white.withOpacity(0.3),
                //                   primary.withOpacity(0.015),
                //                 ],
                //                 begin: Alignment.bottomCenter,
                //                 end: Alignment.topCenter)
                //             // color: index == _selectedItemIndex ? Colors.green : Colors.white,
                //             )
                //         : BoxDecoration(),
                //     child: Icon(
                //       Icons.home,
                //       color: _selectedIndex == _selectedIndex
                //           ? Colors.black
                //           : Colors.grey,
                //     ),
                //   ),

                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                     // if user taps on this dashboard tab will be active
                        _selectedIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: _selectedIndex == 0 ? primary : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color:
                                  _selectedIndex == 0 ? primary : Colors.grey,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10) ,
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // currentScreen =
                        //     Chat(); // if user taps on this dashboard tab will be active
                        _selectedIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.check_box_outlined,
                          color: _selectedIndex == 1 ? primary : Colors.grey,
                        ),
                        Text(
                          'Done',
                          style: TextStyle(
                              color:
                                  _selectedIndex == 1 ? primary : Colors.grey,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),

            // Right Tab bar icons

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
           // if user taps on this dashboard tab will be active
                      _selectedIndex = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.bar_chart_rounded,
                        color: _selectedIndex == 2 ? primary : Colors.grey,
                      ),
                      Text(
                        'Reports',
                        style: TextStyle(
                            color: _selectedIndex == 2 ? primary : Colors.grey,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                     setState(() {
           // if user taps on this dashboard tab will be active
                      _selectedIndex = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: _selectedIndex == 3 ? primary : Colors.grey,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            color: _selectedIndex == 3 ? primary : Colors.grey,
                            fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            )
          ]),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_rounded, size: 25),
          ),
          BottomNavigationBarItem(
            label: 'Team Tasks',
            icon: Icon(Icons.settings, size: 25),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings, size: 25),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
