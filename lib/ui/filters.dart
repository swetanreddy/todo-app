import 'package:flutter/material.dart';
import 'package:todo/startup.dart';
import 'package:todo/theme.dart';
import 'package:todo/ui/HomePage.dart';

class FilterLabels extends StatefulWidget {
  const FilterLabels({Key? key}) : super(key: key);

  @override
  _FilterLabelsState createState() => _FilterLabelsState();
}

class _FilterLabelsState extends State<FilterLabels> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        child: const Image(
                          height: 40,
                          width: 40,
                          image: const AssetImage(
                            'assets/images/backarrow.png',
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const startUpPage()));
                        }),
                    VerticalDivider(
                      color: Colors.grey.shade200,
                      thickness: 1,
                    ),
                    CircleAvatar(
                      backgroundColor: primary,
                      radius: 20,
                      child: Icon(
                        Icons.show_chart_outlined,
                        color: white,
                        size: 18,
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.grey.shade200,
                      thickness: 1,
                    ),
                    Text("2/5", style: kHeadingFont.copyWith(
                        color: black, fontSize: 18, letterSpacing: 0.8),)
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 190,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        children: const <Widget>[
                          ListTile( title: Text("Inbox"), leading: Icon(Icons.inbox), trailing: Text("2"),),
                          ListTile( title: Text("Today"), leading: Icon(Icons.calendar_today_outlined), trailing: Text("4"),),
                          ListTile( title: Text("Upcoming"), leading: Icon(Icons.calendar_view_month)),
                        ],
                      ),
                    )
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      child: Text("Filters & Labels",  style: kHeadingFont.copyWith(
                          color: black, fontSize: 18, letterSpacing: 0.8),),
                      alignment: Alignment.centerLeft,
                    ),
                    Align(
                      child: Icon(Icons.add),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                          children: const <Widget>[
                            ListTile( title: Text("Basic"), leading: Icon(Icons.label), trailing: Text("10"),),
                            ListTile( title: Text("Important"), leading: Icon(Icons.label), trailing: Text("4"),),
                            ListTile( title: Text("Urgent"), leading: Icon(Icons.label), trailing: Text("4"),),
                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
