import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/model/task.dart';
import 'package:todo/ui/TaskViewPage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:todo/ui/filters.dart';
import 'package:todo/helpers/firebase_help.dart';
import 'package:todo/helpers/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var radius = const Radius.circular(20);

  CalendarController? _controller;
  var doneTasks = [];

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {



    TabController _tabController = TabController(length: 3, vsync: this);
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: const Image(
                                    height: 35,
                                    width: 35,
                                    image: AssetImage(
                                      'assets/images/menu.png',
                                    )),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => FilterLabels(),
                                  ));
                                },
                              ),
                              Text(
                                'Task Manager',
                                style: kHeadingFont.copyWith(
                                    color: black, fontSize: 18),
                              ),
                              NamedIcon(
                                text: '',
                                iconData: Icons.notifications_none_rounded,
                                notificationCount: 11,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text("Welcome Back!", style: kHeadingFont),
                        const SizedBox(height: 7),
                        Text("Here's Update Today.", style: kCardTitleFont),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 40,
                    child: TabBar(
                      isScrollable: false,
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text("Today",
                              style: GoogleFonts.montserrat(
                                  fontSize: 11, fontWeight: FontWeight.w500)),
                        ),
                        Tab(
                          child: Text("Upcoming",
                              style: GoogleFonts.montserrat(
                                  fontSize: 11, fontWeight: FontWeight.w500)),
                        ),Tab(
                          child: Text("Created by me",
                              style: GoogleFonts.montserrat(
                                  fontSize: 11, fontWeight: FontWeight.w500)),
                        ),
                      ],
                      indicatorWeight: 3,
                      indicatorColor: primary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      //indicatorPadding: const EdgeInsets.all(10),
                    ),
                  ),
                  SizedBox(
                    width: width * 1,
                    height: 620,
                    child: TabBarView(controller: _tabController, children: [
                      _tasksTodo(),
                      //_fetchNewStatusTasks(),
                      _fetchInprogressStatusTasks(),
                      _fetchInprogressStatusTasks(),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //   builder: (context) =>
                      //       TaskViewPage(taskData: taskItems[index]),
                      // ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          //color: taskItems[index].tagColor,
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Task #${taskItems[index].taskNumber}",
                                  style: kCardHeaderFont),
                              const Spacer(),
                              Text(timeago.format(taskItems[index].datetime!),
                                  style: kCardHeaderFont),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text("${taskItems[index].title}",
                              style: kCardTitleFont),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.5),
                                    child: Text(
                                      "${taskItems[index].tag}",
                                      style: kSubTitleFont.copyWith(
                                          color: Colors.white, fontSize: 11),
                                    ),
                                  ),
                                ),
                              ),
                              //const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 5),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.5),
                                    child: Text(
                                      "Status: ${taskItems[index].status}",
                                      style: kSubTitleFont.copyWith(
                                          color: Colors.white, fontSize: 11),
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
                                          style: kHeadingFont.copyWith(
                                              fontSize: 11)),
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
                                          style: kHeadingFont.copyWith(
                                              fontSize: 11)),
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

  void _selectDay(DateTime day) {
    setState(() {
      print(day);
    });
  }

  void onSelect(DateTime day, List<dynamic> b, List<dynamic> c) {
    print(day);
  }

  Widget _fetchInprogressStatusTasks() => Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
        child: Column(
          children: [
            TableCalendar(
              calendarController: _controller,
              startingDayOfWeek: StartingDayOfWeek.monday,
              availableCalendarFormats: const {
                CalendarFormat.week: 'Week',
              },
              onDaySelected: onSelect,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                selectedColor: primary,
                renderDaysOfWeek: true,
                outsideDaysVisible: false,
                outsideWeekendStyle:
                    const TextStyle().copyWith(color: Colors.black),
                outsideStyle:
                    const TextStyle().copyWith(color: Colors.blueGrey[400]),
                weekdayStyle: kHeadingFont.copyWith(color: greyHeading),
                selectedStyle: kHeadingFont.copyWith(color: Colors.white),
                todayStyle: const TextStyle().copyWith(color: Colors.white),
                todayColor: Colors.grey,
                weekendStyle: kHeadingFont.copyWith(color: greyHeading),
                holidayStyle: TextStyle().copyWith(color: Colors.white),
              ),
              headerStyle: HeaderStyle(
                leftChevronIcon: Icon(Icons.chevron_left, color: primary),
                rightChevronIcon: Icon(Icons.chevron_right, color: primary),
                titleTextStyle: kCardTitleFont.copyWith(fontSize: 13),
                formatButtonTextStyle:
                    const TextStyle().copyWith(color: white, fontSize: 15.0),
                formatButtonDecoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: kHeadingFont.copyWith(color: black),
                weekendStyle: kHeadingFont.copyWith(color: black),
              ),
            ),
          ],
        ),
      );

 var todoTasks = FirebaseFirestore.instance.collection('spark_assignedTasks');
  // .where("to_uid", isNotEqualTo: _auth.currentUser?.email)
  // .where("status", isEqualTo: "");
  Widget _tasksTodo() => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('spark_assignedTasks').where("to_email", isEqualTo: _auth.currentUser?.email).where("status", isEqualTo: "InProgress").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Text("Tasks Loading..."),
                  )
                ],
              ),
            );
          } else {
            print('no of todo is ${snapshot.data?.docs.length}');
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  late QueryDocumentSnapshot<Object?>? taskData =
                      snapshot.data?.docs[index];
                  print("qwdqwdw ${taskData?.id}");
                  // print(
                  //     "date is ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
                  // print("due date is ${taskData!.get('due data')}");
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TaskViewPage(taskData: taskData?.data(), taskId: taskData?.id),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            //color: taskItems[index].tagColor,
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${taskData!['task_title']}",
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
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(color: Colors.white),
                                      color: primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 3.5),
                                      child: Text(
                                        "${taskData.get('dept')}",
                                        style: kSubTitleFont.copyWith(
                                            color: Colors.white, fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 5),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 3.5),
                                      child: Text(
                                        "Status: ${taskData.get('status')}",
                                        style: kSubTitleFont.copyWith(
                                            color: Colors.white, fontSize: 11),
                                      ),
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
                                        Text(
                                            "Assigned by : ${taskData.get('by_name')}",
                                            style: kHeadingFont.copyWith(
                                                fontSize: 11)),
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
                                            "${taskData.get('created_on')} - ${taskData.get('due_date')}",
                                            style: kHeadingFont.copyWith(
                                                fontSize: 11)),
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
                });
          }
        },
      );
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
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              iconData,
              size: 27,
            ),
            Positioned(
              top: 0,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                //alignment: Alignment.topLeft,
                //child: Text('$notificationCount',style: kHeadingFont.copyWith(fontSize: 10,color: ),),
                child: const Text(''),
              ),
            )
          ],
        ),
      ),
    );
  }
}
