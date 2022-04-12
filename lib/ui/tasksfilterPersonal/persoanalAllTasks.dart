import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/helpers/theme.dart';
import 'package:todo/ui/TaskViewPage.dart';

class AllTasksPersonal extends StatefulWidget {
  AllTasksPersonal({Key? key, this.taskFilter}) : super(key: key);
  final taskFilter;
  @override
  _AllTasksPersonalState createState() => _AllTasksPersonalState();
}

class _AllTasksPersonalState extends State<AllTasksPersonal> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: const Image(
                          height: 35,
                          width: 35,
                          image: AssetImage(
                            'assets/images/backarrow.png',
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                    Text(
                      'Task Details',
                      style: kHeadingFont.copyWith(color: black, fontSize: 14),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2),
              SizedBox(
                width: width * 1,
                height: height * 0.85,
                child: _personalAllTasks(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final _auth = FirebaseAuth.instance;

var todoTasks = FirebaseFirestore.instance.collection('spark_assignedTasks');
var personalAllTasks = FirebaseFirestore.instance
    .collection('spark_assignedTasks')
    .where("to_email", isEqualTo: _auth.currentUser?.email)
    .snapshots();
var personalDoneTasks = FirebaseFirestore.instance
    .collection('spark_assignedTasks')
    .where("status", isEqualTo: "Done")
    .where("to_email", isEqualTo: _auth.currentUser?.email)
    .snapshots();
var personalCreatedTasks = FirebaseFirestore.instance
    .collection('spark_assignedTasks')
    .where("by_email", isEqualTo: _auth.currentUser?.email)
    .snapshots();

Widget _personalAllTasks() => StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('spark_assignedTasks')
          .where("to_email", isEqualTo: _auth.currentUser?.email)
          .snapshots(),
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
                        builder: (context) => TaskViewPage(
                            taskData: taskData?.data(), taskId: taskData?.id),
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

Widget _personalDoneTasks() => StreamBuilder<QuerySnapshot>(
      stream: personalDoneTasks,
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
                        builder: (context) => TaskViewPage(
                            taskData: taskData?.data(), taskId: taskData?.id),
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

Widget _personalCreatedTasks() => StreamBuilder<QuerySnapshot>(
      stream: personalCreatedTasks,
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
                        builder: (context) => TaskViewPage(
                            taskData: taskData?.data(), taskId: taskData?.id),
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
