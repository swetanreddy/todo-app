import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/helpers/firestoreData.dart';
import 'package:todo/helpers/theme.dart';
import 'package:todo/ui/TaskViewPage.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

class _ReportState extends State<Report> {
  var chosendays;
  var chosenValue = "All";
  // var done;
  var donecount = 0;
  var index = 0;
  var notdone = 0;
  var total = 0;
  var per;
  var ddonecount = 0;
  var dindex = 0;
  var dnotdone = 0;
  var dtotal = 0;
  var fper;
  // var selected;

  var udonecount = 0;
  var uindex = 0;
  var unotdone = 0;
  // var utotal = 0;
  var uper;
  var daym;
  var time;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();

    // TODO: implement initState
    print(chosenValue);
    // getDocs();
    // setState(() {
    // if (chosenValue != "All") {
    print(chosenValue);
    FirebaseFirestore.instance
        .collection('spark_assignedTasks')
        // .where("dept", isEqualTo: chosenValue)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // if (time != chosendays) {
        if (doc['status'] == "Done") {
          donecount = donecount + 1;
        } else if (doc['status'] == "InProgress") {
          notdone = notdone + 1;
        }

        // var xtime = time *
        // if()

        setState(() {});
      });
      // setState(() {});
    });
    FirebaseFirestore.instance
        .collection('spark_assignedTasks')
        .where("to_email", isEqualTo: "nithe.nithesh@gmail.com")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['status'] == "Done") {
          udonecount = udonecount + 1;
        } else if (doc['status'] == "InProgress") {
          unotdone = unotdone + 1;
        }

        setState(() {});
      });
      // setState(() {});
    });

    // daym = time * 86400000;
    // }
  }

  // CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('spark_assignedTasks');
  // Future getDocs() async {
  //   // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //   //     .collection("spark_assignedTasks")
  //   //     .get();
  //   // for (int i = 0; i < querySnapshot.docs.length; i++) {
  //   // var a = querySnapshot.docs[i];
  //   // QuerySnapshot querySnapshot = await _collectionRef.doc().get().;

  //   // Get data from docs and convert map to List
  //   // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  //   // print(allData);
  //   // print(a.id);
  //   // FirebaseFirestore.instance
  //   //   .collection("spark_assignedTasks").doc("${a.id}").
  //   print("hello");
  //   // }
  // }

  // Widget deps(depw) {
  //   return Expanded(
  //       child: Padding(
  //     padding: const EdgeInsets.only(
  //       right: 8.0,
  //     ),
  //     child: GestureDetector(
  //       onTap: () {
  //         selected = depw;
  //         setState(() {
  //           // setState(() {});
  //         });
  //         print(selected);
  //       },
  //       child: Container(
  //         height: 45,
  //         decoration: BoxDecoration(
  //             color: selected == depw ? primary : Colors.white,
  //             borderRadius: BorderRadius.all(Radius.circular(6)),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.1),
  //                 spreadRadius: 5,
  //                 blurRadius: 10,
  //               )
  //             ]),
  //         child: Center(
  //             child: Text(
  //           depw,
  //           style: kHeadingFont.copyWith(
  //               color: selected == depw ? Colors.white : primary,
  //               fontWeight: FontWeight.w500),
  //         )),
  //       ),
  //     ),
  //   ));
  // }

  var listtype;
  Widget tlist(strem) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: StreamBuilder<QuerySnapshot>(
          stream: strem.snapshots(),
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
                    // var time = taskData!.get('created_on') -
                    // taskData.get('due_date');
                    // DateTime date =
                    //     new DateTime.fromMillisecondsSinceEpoch(
                    //         time);
                    // print("qwdqwdw ${taskData?.id}");
                    // print(
                    //     "date is ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
                    // print("due date is ${taskData!.get('due data')}");
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TaskViewPage(
                                taskData: taskData?.data(),
                                taskId: taskData?.id),
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
                                              color: Colors.white,
                                              fontSize: 11),
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
                                              color: Colors.white,
                                              fontSize: 11),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          Text("test",
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
        ));
  }

  Widget Report(
    fnotdone,
    fdonecount,
  ) {
    double finDouble = 0;
    var ftotal = fdonecount + fnotdone;
    double fperround = 0;
    if (chosenValue != "All") {
      ftotal = fdonecount + fnotdone;

      fper = (fdonecount / ftotal);
      var fperdone = fper.toStringAsFixed(1);
      finDouble = double.parse(fperdone);
      fperround = finDouble * 100;
    }
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      chosenValue.toString(),
                      style: GoogleFonts.montserrat(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            listtype = "total";
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "$ftotal",
                                  style: GoogleFonts.montserrat(fontSize: 40),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Total",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20, color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            listtype = "notdone";
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "$fnotdone",
                                  style: GoogleFonts.montserrat(fontSize: 40),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Not Done",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20, color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            listtype = "Done";
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "$fdonecount",
                                  style: GoogleFonts.montserrat(fontSize: 40),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Done",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20, color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: Text("$fperround"),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      color: Colors.blueGrey[100],
                                      value: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Container(
                                      child: CircularProgressIndicator(
                                        color: Color(0xff00B98D),

                                        value: finDouble != null
                                            ? finDouble
                                            : 0, // Change this value to update the progress
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Progress",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20, color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 300,

                                        // decoration: BoxDecoration(color: Colors.white),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )),
                                    Container(
                                      height: 20,
                                      width: finDouble != null
                                          ? finDouble * 100 * 3
                                          : 0
                                      //  MediaQuery.of(context)
                                      //         .size
                                      // .width *
                                      ,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFF9ec9ff),
                                              Color(0xFF92a9f9),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),

                              // SizedBox(
                              //   width: 10,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))))
        // _chosenValue == "Department"
        //     ?
        // Report(dtotal, dnotdone, ddonecount, dperround,
        //     dinDouble))
        //     :
        // Report(total, notdone, donecount, perround, inDouble)),
        );
  }

  @override
  Widget build(BuildContext context) {
    // total = donecount + notdone;
    // per = (donecount / total);

    // total = donecount + notdone;
    // per = (donecount / total);
    // var perdone = per.toStringAsFixed(1);
    // double inDouble = double.parse(perdone);
    // double perround = inDouble * 100;

    return Scaffold(
      backgroundColor: Color(0xffECF0F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text("REPORT",
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w500)),
              )),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            // begin: Alignment.topRight,
                            // end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFF92a9f9),
                              Color(0xFF9ec9ff),
                            ],
                          )),
                      child: Center(
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          value: chosenValue,
                          dropdownColor: Color(0xFF9ec9ff),

                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          items: <String>[
                            "My Report",
                            "All",
                            "HR",
                            "Legal",
                            "Sales",
                            "CRM",
                            "admin"
                          ].map<DropdownMenuItem<String>>((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value!,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          hint: const Text(
                            "All",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            chosenValue = value!;
                            ddonecount = 0;
                            dnotdone = 0;
                            FirebaseFirestore.instance
                                .collection('spark_assignedTasks')
                                .where("dept", isEqualTo: chosenValue)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                print(doc["by_email"]);
                                if (doc['status'] == "Done") {
                                  ddonecount = ddonecount + 1;
                                } else if (doc['status'] == "InProgress") {
                                  dnotdone = dnotdone + 1;
                                }

                                setState(() {});
                              });
                            });
                            setState(() {});
                            // print(chosenValue);
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            // begin: Alignment.topRight,
                            // end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFF9ec9ff),
                              Color(0xFF92a9f9),
                            ],
                          )),
                      child: Center(
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          value: chosendays,
                          dropdownColor: Color(0xFF9ec9ff),
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          items: <String>["All", "7 Days", "30 Days", "90 Days"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          hint: const Text(
                            "All",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              value == "7 days"
                                  ? time = 7
                                  : value == "30 Days"
                                      ? time = 30
                                      : value == "90 Days"
                                          ? time = 90
                                          : time = 0;
                              chosendays = value;
                              setState(() {});
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              chosenValue != "All" && chosenValue != "My Report"
                  ? Report(
                      dnotdone,
                      ddonecount,
                    )
                  : chosenValue == "My Report"
                      ? Report(unotdone, udonecount)
                      : Report(notdone, donecount),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 18),
                      child: Text("Your Progress",
                          style: GoogleFonts.montserrat(fontSize: 20))),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0, top: 18),
                    child: Text("See More"),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 10, 18, 10),
                  child: chosenValue != "All" && chosenValue != "My Report"
                      ? listtype == "Done"
                          ? tlist(FirebaseFirestore.instance
                              .collection('spark_assignedTasks')
                              .where("dept", isEqualTo: chosenValue)
                              // .where("time", isLessThan: daym)
                              .where("status", isEqualTo: "Done"))
                          : listtype == "notdone"
                              ? tlist(FirebaseFirestore.instance
                                  .collection('spark_assignedTasks')
                                  .where("dept", isEqualTo: chosenValue)
                                  .where("status", isEqualTo: "InProgress"))
                              : tlist(FirebaseFirestore.instance
                                  .collection('spark_assignedTasks')
                                  .where("dept", isEqualTo: chosenValue))
                      : chosenValue == "My Report"
                          ? Container(
                              child: listtype == "Done"
                                  ? tlist(FirebaseFirestore.instance
                                      .collection('spark_assignedTasks')
                                      .where("to_email",
                                          isEqualTo: currentUser!.email)
                                      .where("status", isEqualTo: "Done"))
                                  : listtype == "notdone"
                                      ? tlist(FirebaseFirestore.instance
                                          .collection('spark_assignedTasks')
                                          .where("status",
                                              isEqualTo: "InProgress")
                                          .where("to_email",
                                              isEqualTo: currentUser!.email))
                                      : tlist(FirebaseFirestore.instance
                                          .collection('spark_assignedTasks')
                                          .where("to_email", isEqualTo: currentUser!.email)))
                          : Container(
                              child: listtype == "Done"
                                  ? tlist(FirebaseFirestore.instance.collection('spark_assignedTasks').where("status", isEqualTo: "Done"))
                                  : listtype == "notdone"
                                      ? tlist(FirebaseFirestore.instance.collection('spark_assignedTasks').where("status", isEqualTo: "InProgress"))
                                      : tlist(FirebaseFirestore.instance.collection('spark_assignedTasks'))))
            ],
          ),
        ),
      ),
    );
  }
}
