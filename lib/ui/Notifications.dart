import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/auth/LoginPage.dart';
import 'package:todo/startup.dart';
import 'package:todo/ui/HomePage.dart';
import 'package:todo/ui/ProfilePage.dart';
import 'package:todo/ui/SelectMembers.dart';
import 'package:todo/ui/firebase_help.dart';
import 'package:todo/ui/firebase_help.dart';
import 'package:todo/theme.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}
class CheckBoxListTileModel {
  int userId;
  String title;
  bool isCheck;

  CheckBoxListTileModel({required this.userId,required this.title,required this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          userId: 1,
          title: "Task assigned to me",
          isCheck: true),
      CheckBoxListTileModel(
          userId: 2,
          title: "Task Completed",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 3,
          title: "Mention me",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 4,
          title: "Direct Message",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 5,
          title: "Group Message",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 6,
          title: "Email notification",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 7,
          title: "Update info",
          isCheck: false),
    ];
  }
}
class _NotificationsState extends State<Notifications> {
  bool? _value = false;
  List<CheckBoxListTileModel> checkBoxListTileModel =
  CheckBoxListTileModel.getUsers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Padding(
            padding: const EdgeInsets.only(top: 30,left: 20,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0,left: 0,right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: const Image(
                            height: 20,
                            width: 20,
                            image: AssetImage('assets/images/backarrow.png',),
                          ),
                          onTap: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ProfilePage()));}


                      ),

                      Text('Notifications',style: kHeadingFont.copyWith(color: black,fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.edit,color: Colors.white,),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0,),
          Container(
            height: 600,
            child: ListView.builder(
                itemCount: checkBoxListTileModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: new Container(
                      padding: new EdgeInsets.all(0),
                      child: Column(
                        children: <Widget>[
                          new CheckboxListTile(
                              shape: const CircleBorder(),
                              activeColor: primary,
                              dense: true,
                              //font change
                              title: new Text(
                                checkBoxListTileModel[index].title,
                                style: kHeadingFont.copyWith(color: black),
                              ),
                              value: checkBoxListTileModel[index].isCheck,
                              onChanged: (val) {
                                itemChange(val, index);
                              })
                        ],
                      ),
                    ),
                  );
                }),
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void itemChange(bool? val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val!;
    });
  }
}


