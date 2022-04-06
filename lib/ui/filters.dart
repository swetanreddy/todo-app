import 'package:flutter/material.dart';
import 'package:todo/helpers/theme.dart';
import 'package:todo/ui/tasksfilterPersonal/persoanalAllTasks.dart';
import 'package:todo/ui/tasksfilterPersonal/personalCreatedTasks.dart';
import 'package:todo/ui/tasksfilterPersonal/personalDoneTasks.dart';
import 'package:todo/ui/tasksfilterTeam/teamAllTasks.dart';
import 'package:todo/ui/tasksfilterTeam/teamDoneTasks.dart';
import 'package:todo/ui/tasksfilterTeam/teamUpcomingTasks.dart';

class FilterLabels extends StatefulWidget {
  const FilterLabels({Key? key}) : super(key: key);

  @override
  _FilterLabelsState createState() => _FilterLabelsState();
}

class _FilterLabelsState extends State<FilterLabels> {

  String? taskFilter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        child: const Image(
                          height: 40,
                          width: 40,
                          image: AssetImage('assets/images/backarrow.png'),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
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
                const SizedBox(height: 10),
                Align(
                  child: Text("Personal Tasks",  style: kHeadingFont.copyWith(
                      color: black, fontSize: 18, letterSpacing: 0.8),),
                  alignment: Alignment.centerLeft,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
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
                        children: <Widget>[
                          ListTile(
                            title: const Text("All"),
                            leading: const Icon(Icons.inbox),
                            onTap: () {
                              setState(() {
                                taskFilter = "personalAll";
                              });
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) => AllTasksPersonal(taskFilter: taskFilter)));
                            },
                          ),
                          ListTile(
                            title: const Text("Done"),
                            leading: const Icon(Icons.calendar_today_outlined),
                            onTap: () {
                              setState(() {
                                taskFilter = "personalDone";
                              });
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) => doneTasksPersonal(taskFilter: taskFilter)));
                            },
                          ),
                          ListTile(
                            title: const Text("Created By Me"),
                            leading: const Icon(Icons.calendar_view_month),
                            onTap: () {
                              setState(() {
                                taskFilter = "personalCreatedByMe";
                              });
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) => createdTasksPersonal(taskFilter: taskFilter)));
                            },
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  child: Text("Team Tasks",  style: kHeadingFont.copyWith(
                      color: black, fontSize: 18, letterSpacing: 0.8),),
                  alignment: Alignment.centerLeft,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
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
                          children: <Widget>[
                            ListTile(
                              title: const Text("All"),
                              leading: const Icon(Icons.inbox),
                              onTap: () {
                                setState(() {
                                  taskFilter = "teamAll";
                                });
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => AllTasksTeam(taskFilter: taskFilter)));
                              },
                            ),
                            ListTile(
                              title: const Text("Done"),
                              leading: const Icon(Icons.calendar_today_outlined),
                              onTap: () {
                                setState(() {
                                  taskFilter = "teamDone";
                                });
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => DoneTasksTeam(taskFilter: taskFilter)));
                              },
                            ),
                            ListTile(
                              title: const Text("Upcoming"),
                              leading: const Icon(Icons.calendar_view_month),
                              onTap: () {
                                setState(() {
                                  taskFilter = "teamUpcoming";
                                });
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => UpcomingTasksTeam(taskFilter: taskFilter)));
                              },
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      child: Text("Filters & Labels",  style: kHeadingFont.copyWith(
                          color: black, fontSize: 18, letterSpacing: 0.8),),
                      alignment: Alignment.centerLeft,
                    ),
                    const Align(
                      child: Icon(Icons.add),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
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
                            ListTile(
                              title: Text("Basic"),
                              leading: Icon(Icons.label),
                              trailing: Text("10"),
                            ),
                            ListTile(
                              title: Text("Important"),
                              leading: Icon(Icons.label),
                              trailing: Text("4"),
                            ),
                            ListTile(
                              title: Text("Urgent"),
                              leading: Icon(Icons.label),
                              trailing: Text("4"),
                            ),
                          ],
                        ),
                      )
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
