import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/auth/LoginPage.dart';
import 'package:todo/auth/authenticate.dart';
import 'package:todo/startup.dart';
import 'package:todo/ui/HomePage.dart';
import 'package:todo/ui/SelectMembers.dart';
import 'package:todo/ui/firebase_help.dart';
import 'package:todo/ui/firebase_help.dart';
import 'package:todo/theme.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Image(
                  height: 400,
                  width: 500,
                  image: AssetImage(
                    'assets/images/splash.png',
                  ),
                ),
              ),
              Image(
                height: 200,
                width: 500,
                image: AssetImage(
                  'assets/images/splashtext.png',
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => Authenticate()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 0, right: 20),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
