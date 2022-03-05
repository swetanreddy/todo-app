import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/helpers/methods.dart';
import 'package:todo/model/task.dart';
import 'package:todo/ui/TaskViewPage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:todo/ui/filters.dart';
import 'package:todo/ui/firebase_help.dart';
import 'package:todo/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var radius = const Radius.circular(20);

  var doneTasks = [];

  final data = FirebaseFirestore.instance
      .collection('assignedTasks')
      .where('email', isEqualTo: '${FirebaseAuth.instance.currentUser!.email}')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 30.0),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Padding(
                          padding: const EdgeInsets.only(top: 0,bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: const Image(
                                  height: 35,
                                  width: 35,
                                  image: AssetImage('assets/images/menu.png',),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => FilterLabels(),
                                  ));
                                },
                              ),

                              Text('Task Manager',style: kHeadingFont.copyWith(color: black,fontSize: 14),),
                              NamedIcon(
                                text: '',
                                iconData: Icons.notifications_none_rounded,
                                notificationCount: 11,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25,),
                        Text("Welcome Back!",
                            style: kHeadingFont),
                        SizedBox(height: 7),
                        Text("Here's Update Today.",
                            style: kCardTitleFont),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 30,
                    child: TabBar(
                      isScrollable: false,
                      controller: _tabController,
                      // labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      tabs:  [
                        Tab(
                            child: Text("To Do",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500),
                            ),
                        ),
                        Tab(
                            child: Text("Ongoing",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500
                                ),
                            ),
                        ),
                        Tab(
                            child: Text("Blocked",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500
                                ),
                            ),
                        ),
                        Tab(
                            child: Text("Done",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500
                                ),
                            ),
                        ),
                      ],
                      indicator: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(radius)),
                          color: primary),
                    ),
                  ),
                  SizedBox(
                    width: width * 1,
                    height: 620,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _fetchNewStatusTasks(),
                        _fetchInprogressStatusTasks(),
                        _fetchBlockedStatusTasks(),
                        // _fetchDoneStatusTasks()
                        _fetchDoneTasks(_auth.currentUser?.email)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0,
      //   foregroundColor: Colors.white,
      //   backgroundColor: Colors.black,
      //   onPressed: () {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (context) => const CreateTask(),
      //     ));
      //   },
      //   child: const Icon(Icons.add, size: 30),
      // ),
    );
  }

  Widget _fetchNewStatusTasks() => Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: ListView.builder(
            itemCount: taskItems.length,
            itemBuilder: (context, index) {
              if (taskItems[index].status == "New") {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            TaskViewPage(task: taskItems[index]),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          //color: taskItems[index].tagColor,
                          color: white,
                          boxShadow: [BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 5.0,
                          ),],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Task #${taskItems[index].taskNumber}",
                                style: kCardHeaderFont
                              ),
                              const Spacer(),
                              Text(
                                timeago.format(taskItems[index].datetime!),
                                style:kCardHeaderFont
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "${taskItems[index].title}",
                            style: kCardTitleFont
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: primary),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.5),
                                    child: Text(
                                      "${taskItems[index].tag}",
                                      style: kSubTitleFont.copyWith(color: Colors.black,fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              //const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19),
                                    border: Border.all(color: primary),
                                    //color: taskItems[index].tagColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.5),
                                    child: Text(
                                      "Priority ${taskItems[index].priority}",
                                      style: kSubTitleFont.copyWith(color: Colors.black,fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18.0),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "Assigned by : ${taskItems[index].assignedBy}",
                                          style: kHeadingFont.copyWith(fontSize: 11)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timer,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "${taskItems[index].startDate} - ${taskItems[index].endDate}",
                                          style: kHeadingFont.copyWith(fontSize: 11)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox(height: 0.0);
              }
            }),
      );

  Widget _fetchDoneStatusTasks() => Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView.builder(
            itemCount: taskItems.length,
            itemBuilder: (context, index) {
              if (taskItems[index].status == "Done") {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            TaskViewPage(task: taskItems[index]),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: taskItems[index].tagColor,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Task #${taskItems[index].taskNumber}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                timeago.format(taskItems[index].datetime!),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            "${taskItems[index].title}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.white),
                                    color: taskItems[index].tagColor,
                                  ),
                                  child: Text(
                                    "${taskItems[index].tag}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.white),
                                    color: taskItems[index].tagColor,
                                  ),
                                  child: Text(
                                    "Status: ${taskItems[index].status}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text("Assigned by : ${taskItems[index].assignedBy}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timer,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text("${taskItems[index].startDate} - ${taskItems[index].endDate}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox(height: 0.0);
              }
            }),
      );

  Widget _fetchInprogressStatusTasks() => Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView.builder(
            itemCount: taskItems.length,
            itemBuilder: (context, index) {
              if (taskItems[index].status == "In Progress") {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            TaskViewPage(task: taskItems[index]),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        //color: taskItems[index].tagColor,
                          color: white,
                          boxShadow: [BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 5.0,
                          ),],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "Task #${taskItems[index].taskNumber}",
                                  style: kCardHeaderFont
                              ),
                              const Spacer(),
                              Text(
                                  timeago.format(taskItems[index].datetime!),
                                  style:kCardHeaderFont
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                              "${taskItems[index].title}",
                              style: kCardTitleFont
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: Colors.white),
                                    color: primary,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.5),
                                    child: Text(
                                      "${taskItems[index].tag}",
                                      style: kSubTitleFont.copyWith(color: Colors.white,fontSize: 11),
                                    ),
                                  ),
                                ),
                              ),
                              //const Spacer(),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19),
                                    //border: Border.all(color: Colors.white),
                                    color: primary,
                                    //color: taskItems[index].tagColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3.5),
                                    child: Text(
                                      "Status: ${taskItems[index].status}",
                                      style: kSubTitleFont.copyWith(color: Colors.white,fontSize: 11),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18.0),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "Assigned by : ${taskItems[index].assignedBy}",
                                          style: kHeadingFont.copyWith(fontSize: 11)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timer,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "${taskItems[index].startDate} - ${taskItems[index].endDate}",
                                          style: kHeadingFont.copyWith(fontSize: 11)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox(height: 0.0);
              }
            }),
      );

  Widget _fetchBlockedStatusTasks() => Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView.builder(
            itemCount: taskItems.length,
            itemBuilder: (context, index) {
              if (taskItems[index].status == "Blocked") {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            TaskViewPage(task: taskItems[index]),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        //color: taskItems[index].tagColor,
                          color: white,
                          boxShadow: [BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 5.0,
                          ),],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "Task #${taskItems[index].taskNumber}",
                                  style: kCardHeaderFont
                              ),
                              const Spacer(),
                              Text(
                                  timeago.format(taskItems[index].datetime!),
                                  style:kCardHeaderFont
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                              "${taskItems[index].title}",
                              style: kCardTitleFont
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: Colors.white),
                                    color: primary,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.5),
                                    child: Text(
                                      "${taskItems[index].tag}",
                                      style: kSubTitleFont.copyWith(color: Colors.white,fontSize: 11),
                                    ),
                                  ),
                                ),
                              ),
                              //const Spacer(),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19),
                                    //border: Border.all(color: Colors.white),
                                    color: primary,
                                    //color: taskItems[index].tagColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.5),
                                    child: Text(
                                      "Status: ${taskItems[index].status}",
                                      style: kSubTitleFont.copyWith(color: Colors.white,fontSize: 11),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18.0),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "Assigned by : ${taskItems[index].assignedBy}",
                                          style: kHeadingFont.copyWith(fontSize: 11)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timer,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "${taskItems[index].startDate} - ${taskItems[index].endDate}",
                                          style: kHeadingFont.copyWith(fontSize: 11)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox(height: 0.0);
              }
            }),
      );

  Widget _fetchDoneTasks(email) => FutureBuilder(
    future: DBQuery.instanace.getTasksBySignedInUser(_auth.currentUser?.email),
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView.builder(
              itemCount: taskItems.length,
              itemBuilder: (context, index) {
                if (taskItems[index].status == "Done") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              TaskViewPage(task: taskItems[index]),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //color: taskItems[index].tagColor,
                            color: white,
                            boxShadow: [BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 5.0,
                            ),],
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "Task #${taskItems[index].taskNumber}",
                                    style: kCardHeaderFont
                                ),
                                const Spacer(),
                                Text(
                                    timeago.format(taskItems[index].datetime!),
                                    style:kCardHeaderFont
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                                "${taskItems[index].title}",
                                style: kCardTitleFont
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(color: Colors.white),
                                      color: primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.5),
                                      child: Text(
                                        "${taskItems[index].tag}",
                                        style: kSubTitleFont.copyWith(color: Colors.white,fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ),
                                //const Spacer(),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(19),
                                      //border: Border.all(color: Colors.white),
                                      color: primary,
                                      //color: taskItems[index].tagColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.5),
                                      child: Text(
                                        "Status: ${taskItems[index].status}",
                                        style: kSubTitleFont.copyWith(color: Colors.white,fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18.0),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today_outlined,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                            "Assigned by : ${taskItems[index].assignedBy}",
                                            style: kHeadingFont.copyWith(fontSize: 11)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.timer,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                            "${taskItems[index].startDate} - ${taskItems[index].endDate}",
                                            style: kHeadingFont.copyWith(fontSize: 11)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(height: 0.0);
                }
              }),
        );
      }else{
        return const Center(child: CircularProgressIndicator());
      }
    },
  );

  // late Query<Map<String, dynamic>> todoTasks = FirebaseFirestore.instance.collection('assignedTasks').where("Assigned to", isEqualTo: _auth.currentUser?.email).where("status", isEqualTo: "TO DO");
  // Widget _tasksTodo() => StreamBuilder<QuerySnapshot>(
  //   stream: todoTasks.snapshots(),
  //   builder: (context, snapshot) {
  //     if (!snapshot.hasData) {
  //       return Column(
  //         children: const [
  //           Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //           SizedBox(height: 50),
  //           Center(
  //             child: Text("Tasks Loading..."),
  //           )
  //         ],
  //       );
  //     } else {
  //       return ListView.builder(
  //           itemCount: snapshot.data?.docs.length,
  //           itemBuilder: (context, index) {
  //             final taskData = snapshot.data?.docs[index];
  //             print("qwdqwdw ${taskData?.data()}");
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 8),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                     builder: (context) => TaskViewPage(task: taskData?.data()),
  //                   ));
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       color: taskItems[index].tagColor,
  //                       borderRadius: BorderRadius.circular(8)),
  //                   padding: const EdgeInsets.all(16),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text("${taskData!.get('Task Title')}",
  //                         style: const TextStyle(
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 20.0),
  //                       Row(
  //                         children: [
  //                           Padding(
  //                             padding:
  //                             const EdgeInsets.symmetric(vertical: 4),
  //                             child: Container(
  //                               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(4),
  //                                 border: Border.all(color: Colors.white),
  //                                 color: taskItems[index].tagColor,
  //                               ),
  //                               child: Text("${taskData.get('department')}",
  //                                 style: const TextStyle(color: Colors.white),
  //                               ),
  //                             ),
  //                           ),
  //                           const Spacer(),
  //                           Padding(
  //                             padding:
  //                             const EdgeInsets.symmetric(vertical: 4),
  //                             child: Container(
  //                               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(4),
  //                                 border: Border.all(color: Colors.white),
  //                                 color: taskItems[index].tagColor,
  //                               ),
  //                               child: Text("Status: ${taskData.get('status')}",
  //                                 style: const TextStyle(color: Colors.white),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(height: 10.0),
  //                       Row(
  //                         children: [
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisAlignment: MainAxisAlignment.end,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   const Icon(Icons.calendar_today_outlined, size: 12),
  //                                   const SizedBox(width: 8),
  //                                   Text("Assigned by : ${taskData.get('Assigned by')}",
  //                                     style: const TextStyle(
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ],
  //                               ),
  //                               const SizedBox(height: 12),
  //                               Row(
  //                                 children: [
  //                                   const Icon(Icons.timer, size: 12),
  //                                   const SizedBox(width: 8),
  //                                   Text("${taskData.get('created on')} - ${taskData.get('due data')}",
  //                                     style: const TextStyle(
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           });
  //     }
  //   },
  // );
}

class NamedIcon extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  final int notificationCount;

  const NamedIcon({
    Key? key,
    this.onTap,
    required this.text,
    required this.iconData,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(iconData,size: 27,),
            Positioned(
              top: 0,
              right: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                //alignment: Alignment.topLeft,
                //child: Text('$notificationCount',style: kHeadingFont.copyWith(fontSize: 10,color: ),),
                child: Text(''),
              ),
            )
          ],
        ),
      ),
    );
  }
}