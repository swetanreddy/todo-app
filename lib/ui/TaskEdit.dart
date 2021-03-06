import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/HomePage.dart';
import 'package:todo/ui/startup.dart';
import 'package:todo/ui/SelectMembers.dart';
import 'package:todo/helpers/firebase_help.dart';
import 'package:todo/helpers/theme.dart';

class EditTask extends StatefulWidget {

  final taskDetails;
  final taskId;
  const EditTask({Key? key, this.taskDetails, this.taskId}) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  String taskTitle = '';
  String taskDescription = '';
  String? bucketValue;
  String? statusValue;
  String? priorityValue;
  String? assignedToUserName;
  String? assignedToUserEmail;
  String viewPage = 'createHome';
  String assignedToName = '';
  String assignedToUid = '';
  String assignedToDept = '';
  String assignedToEmail = '';

  late DateTime selectedDateTime = DateTime.now();
  bool pressed = false;

  int _taskTypeIndex = 0;
  List<String> _taskTypeItem = [
    "Basic",
    "Urgent",
    "Important",
  ];
  String _taskType = "Basic";

  TextEditingController _taskTitle = TextEditingController();
  TextEditingController _taskDescription = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  bool showUsers = false;

  var usersDeptArray = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<DropdownMenuItem<String>> get bucketDropDownItems {
    List<DropdownMenuItem<String>> departmentItems = [
      const DropdownMenuItem(child: Text("Finance"), value: "Finance"),
      const DropdownMenuItem(child: Text("HR"), value: "HR"),
      const DropdownMenuItem(child: Text("IT"), value: "IT"),
      const DropdownMenuItem(child: Text("CRM"), value: "CRM"),
      const DropdownMenuItem(child: Text("Site Visit"), value: "Site Visit"),
      const DropdownMenuItem(child: Text("Executive"), value: "Executive"),
      const DropdownMenuItem(
          child: Text("Legal Advice"), value: "Legal Advice"),
    ];
    return departmentItems;
  }

  List<DropdownMenuItem<String>> get statusDropDownItems {
    List<DropdownMenuItem<String>> statusItems = [
      const DropdownMenuItem(child: Text("TO DO"), value: "TO DO"),
      const DropdownMenuItem(child: Text("Incomplete"), value: "Incomplete"),
      const DropdownMenuItem(child: Text("Blocked"), value: "Blocked"),
      const DropdownMenuItem(child: Text("Completed"), value: "Completed"),
    ];
    return statusItems;
  }

  List<DropdownMenuItem<String>> get priorityItems {
    List<DropdownMenuItem<String>> statusItems = [
      const DropdownMenuItem(child: Text("Basic"), value: "Basic"),
      const DropdownMenuItem(child: Text("Medium"), value: "Medium"),
      const DropdownMenuItem(child: Text("High"), value: "High"),
      const DropdownMenuItem(child: Text("Urgent"), value: "Urgent"),
    ];
    return statusItems;
  }

  Future<void> editUser() {
    var assignedTasks =
    FirebaseFirestore.instance.collection('spark_assignedTasks').doc(widget.taskId);

    return assignedTasks
        .update({
      'task_title': _taskTitle.text,
      'task_desc': _taskDescription.text,
      'created_on': widget.taskDetails['created_on'],
      'updated_on': DateTime.now().millisecondsSinceEpoch,
      'due_date': selectedDateTime.microsecondsSinceEpoch,
      'by_email': _auth.currentUser?.email,
      'by_name': _auth.currentUser?.displayName,
      'by_uid': _auth.currentUser?.uid,
      'to_name': assignedToName,
      'to_uid': assignedToUid,
      'to_email': assignedToEmail,
      'dept': assignedToDept,
      'status': statusValue,
    })
        .then((value) => print("Task Edited"))
        .catchError((error) => print("Failed to create task: $error"));
  }

  String? fileName;
  String? path;
  late Map<String, String> paths;
  String? extension;
  bool? loadingPath = false;
  bool? multiPick = false;
  bool? hasValidMime = false;
  FileType? pickingType;
  final TextEditingController _filePicker = TextEditingController();

  // void filePicker() async {
  //   if(pickingType != FileType.custom || hasValidMime!) {
  //     setState(() {
  //       loadingPath = true;
  //     });
  //     try {
  //       if( multiPick) {
  //
  //       }
  //     }
  //   }
  // }

  @override
  void initState() {
    dateinput.text = "";
    _taskTitle.text = widget.taskDetails['task_title'];
    _taskDescription.text = widget.taskDetails['task_desc'];
    selectedDateTime = DateTime(widget.taskDetails['due_date']);
    assignedToName = widget.taskDetails['to_name'];
    assignedToUid = widget.taskDetails['to_uid'];
    assignedToEmail = widget.taskDetails['to_email'];
    assignedToDept = widget.taskDetails['dept'];
    statusValue = widget.taskDetails['status'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   foregroundColor: Colors.black,
        //   iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        //   leading: GestureDetector(
        //     child: Icon(Icons.arrow_back_rounded),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => startUpPgae()),
        //       );
        //     },
        //   ),
        //   title: const Text(
        //     "Create New Task",
        //     style: TextStyle(color: Colors.black, fontSize: 18),
        //   ),
        // ),
        body: viewPage == 'createHome'
            ? SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            child: const Image(
                              height: 20,
                              width: 20,
                              image: const AssetImage(
                                'assets/images/backarrow.png',
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const startUpPage()));
                            }),
                        Text('EDIT TASK',
                            style: kHeadingFont.copyWith(
                                color: black,
                                fontSize: 18,
                                letterSpacing: 0.8)),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            final collection = FirebaseFirestore.instance.collection('spark_assignedTasks');
                            collection
                                .doc(widget.taskId) // <-- Doc ID to be deleted.
                                .delete() // <-- Delete
                                .then((_) => print('Deleted'))
                                .catchError((error) => print('Delete failed: $error'));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const startUpPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5.0),
                    child: Text(
                      'Task Title',
                      style: kHeadingFont.copyWith(
                          color: black, fontSize: 18),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: primary,
                              radius: 16,
                              child: Icon(
                                Icons.add_task_outlined,
                                color: white,
                                size: 18,
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.shade200,
                              thickness: 1,
                            ),
                            Container(
                              width: 250,
                              child: TextFormField(
                                controller: _taskTitle,
                                cursorColor: Colors.grey.shade200,
                                onChanged: (text) {
                                  print('onchanges ${text}   ${_taskTitle.value.text}');
                                  // setState(() {
                                  //   _taskTitle.text = text;
                                  // });
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(
                                        left: 8,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "Task Title",
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade300)),
                              ),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          'Assign To',
                          style: kHeadingFont.copyWith(
                              color: black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            viewPage = "selectMember";
                          });
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>
                          //         const SelectMember()));
                        },
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: primary,
                                radius: 16,
                                child: Icon(
                                  Icons.add,
                                  color: white,
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.grey.shade200,
                                thickness: 1,
                              ),
                              Text(
                                '${assignedToName}',
                                style: kTextFont.copyWith(),
                              ),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Priority',
                      style: kHeadingFont.copyWith(
                          color: black, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: primary,
                            radius: 16,
                            child: Icon(
                              Icons.priority_high,
                              color: white,
                              size: 18,
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.grey.shade200,
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _taskTypeIndex = 0;
                                _taskType = _taskTypeItem[_taskTypeIndex];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: _taskTypeIndex == 0
                                      ? primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(color: primary)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Center(
                                child: Text(
                                  "Low",
                                  style: TextStyle(
                                    color: _taskTypeIndex == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _taskTypeIndex = 1;
                                _taskType = _taskTypeItem[_taskTypeIndex];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: _taskTypeIndex == 1
                                      ? primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(color: primary)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: Center(
                                child: Text(
                                  "Medium",
                                  style: TextStyle(
                                    color: _taskTypeIndex == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _taskTypeIndex = 2;
                                _taskType = _taskTypeItem[_taskTypeIndex];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: _taskTypeIndex == 2
                                      ? primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(color: primary)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: Center(
                                child: Text(
                                  "High",
                                  style: TextStyle(
                                    color: _taskTypeIndex == 2
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Due Date',
                      style: kHeadingFont.copyWith(
                          color: black, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10),
                    child: Row(
                      children: [
                        // Expanded(
                        //     child: Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     CircleAvatar(
                        //       backgroundColor: primary,
                        //       radius: 20,
                        //       child: Icon(
                        //         Icons.priority_high,
                        //         color: white,
                        //         size: 20,
                        //       ),
                        //     ),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(left: 8.0, top: 1),
                        //           child: Text(
                        //             "Priority",
                        //             style: kHeadingFont.copyWith(fontSize: 14),
                        //           ),
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.only(left: 5, right: 0),
                        //           child: Container(
                        //             height: 26,
                        //             width: 100,
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(left: 4.0),
                        //               child: DropdownButton(
                        //                 value: priorityValue,
                        //                 icon: const Icon(Icons.keyboard_arrow_down),
                        //                 items: priorityItems,
                        //                 onChanged: (String? newValue) {
                        //                   setState(() {
                        //                     priorityValue = newValue!;
                        //                   });
                        //                 },
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     )
                        //   ],
                        // )),
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  // pressed = true;

                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        print(
                                            'change ${date.millisecondsSinceEpoch} ${date} in time zone ' +
                                                date.timeZoneOffset.inHours
                                                    .toString());
                                      }, onConfirm: (date) {
                                        setState(() {
                                          selectedDateTime = date;
                                        });
                                      }, currentTime: DateTime.now());
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: primary,
                                    radius: 16,
                                    child: Icon(
                                      Icons.calendar_today_rounded,
                                      color: white,
                                      size: 18,
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.grey.shade200,
                                    thickness: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 12),
                                        child: Text(
                                          "${DateFormat('dd-MMMM-yyyy  kk:mm').format(selectedDateTime)}",
                                          style: kTextFont.copyWith(),
                                        ),
                                      ),

                                      // Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         left: 0, top: 0),
                                      //     child: Container(
                                      //       height: 30,
                                      //       width: 100,
                                      //       child: TextFormField(
                                      //         controller: dateinput,
                                      //         decoration: InputDecoration(
                                      //             border: InputBorder.none,
                                      //             focusedBorder:
                                      //                 InputBorder.none,
                                      //             enabledBorder:
                                      //                 InputBorder.none,
                                      //             errorBorder:
                                      //                 InputBorder.none,
                                      //             disabledBorder:
                                      //                 InputBorder.none,
                                      //             contentPadding:
                                      //                 const EdgeInsets.only(
                                      //                     left: 8,
                                      //                     bottom: 15,
                                      //                     top: 8,
                                      //                     right: 8),
                                      //             hintText: "Date",
                                      //             hintStyle:
                                      //                 kHeadingFont.copyWith(
                                      //                     color: black,
                                      //                     fontSize: 10)),
                                      //         readOnly: true,
                                      //         onTap: () async {
                                      //           DateTime? pickedDate =
                                      //               await showDatePicker(
                                      //                   context: context,
                                      //                   initialDate:
                                      //                       DateTime.now(),
                                      //                   firstDate:
                                      //                       DateTime.now(),
                                      //                   lastDate:
                                      //                       DateTime(2101));

                                      //           if (pickedDate != null) {
                                      //             String formattedDate =
                                      //                 DateFormat('yyyy-MM-dd')
                                      //                     .format(pickedDate);
                                      //             print(formattedDate);
                                      //             setState(() {
                                      //               dateinput.text =
                                      //                   formattedDate;
                                      //             });
                                      //           } else {
                                      //             print(
                                      //                 "Date is not selected");
                                      //           }
                                      //         },
                                      //       ),
                                      //     )),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Description',
                      style: kHeadingFont.copyWith(
                          color: black, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20),
                    child: TextFormField(
                      controller: _taskDescription,
                      onChanged: (text) {
                        // setState(() {
                        //   _taskDescription.text = text;
                        // });
                      },
                      minLines: 5,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Type Here',
                          hintStyle:
                          TextStyle(color: Colors.grey.shade400)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Attachments',
                      style: kHeadingFont.copyWith(
                          color: black, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.attachment_outlined),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 50, right: 50),
                    child: customButton(),
                  ),
                ],
              ),
            ),
          ),
        )
            : SelectMember(
            setPageViewerFun: setPageViewerFun,
            assignedToDetailsFun: assignedToDetailsFun));
  }

  setPageViewerFun() {
    setState(() {
      viewPage = 'createHome';
    });
  }

  assignedToDetailsFun(details) {
    print('i was clicked ${details['department']} ');

    setState(() {
      assignedToName = details['name'];
      assignedToUid = details['uid'];
      assignedToEmail = details['email'];
      assignedToDept = details['department']

      ;
    });
  }

  Widget customButton() {
    return GestureDetector(
      onTap: () {
        editUser();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_) =>
                const startUpPage()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: primary,
            ),
            alignment: Alignment.center,
            child: Text(
              "Update Now",
              style: kSubmitFont,
            )),
      ),
    );
  }

  Widget buildTaskTitle() => TextFormField(
      controller: _taskTitle,
      decoration: const InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.length < 4) {
          return 'Enter at least 4 characters';
        } else {
          return null;
        }
      },
      maxLength: 30,
      onEditingComplete: () {
        print('edit completed ');
      },
      onChanged: (value) {
        print('i was changed  ${value}');
        taskTitle = _taskTitle.text;
      },
      onSaved: (value) {
        setState(() {
          taskTitle = value!;
          value = _taskTitle.text;
        });
      });

  Widget buildTaskDescription() => TextFormField(
      controller: _taskDescription,
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.length < 4) {
          return 'Enter at least 20 characters';
        } else {
          return null;
        }
      },
      maxLength: 250,
      maxLines: 6,
      onSaved: (value) {
        setState(() {
          taskDescription = value!;
          value = _taskDescription.text;
        });
      });

  Widget buildDateInput() => TextFormField(
    controller: dateinput,
    decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today), labelText: "Select a Due Date"),
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101));

      if (pickedDate != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        print(formattedDate);
        setState(() {
          dateinput.text = formattedDate;
        });
      } else {
        print("Date is not selected");
      }
    },
  );

  Widget setStatus() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Set Status", style: TextStyle(fontSize: 18)),
      const SizedBox(height: 5.0),
      DropdownButtonFormField(
          hint: const Text(
            "Set Status",
            style: TextStyle(color: Colors.black),
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            filled: false,
            fillColor: Colors.black,
          ),
          value: statusValue,
          validator: (value) => value == null ? "Set Status" : null,
          dropdownColor: Colors.grey,
          onChanged: (String? newValue) {
            setState(() {
              statusValue = newValue!;
            });
          },
          items: statusDropDownItems),
    ],
  );

  Widget selectDepartment() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Select Department", style: TextStyle(fontSize: 18)),
      const SizedBox(height: 5.0),
      DropdownButtonFormField(
          hint: const Text(
            "Select Department",
            style: TextStyle(color: Colors.black),
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            filled: false,
            fillColor: Colors.black,
          ),
          validator: (value) => value == null ? "Select Department" : null,
          dropdownColor: Colors.grey,
          value: bucketValue,
          onChanged: (String? newValue) async {
            //call firebase function to get users where department == 'newValue'
            var x = await DbQuery.instanace.getUsersByDept(newValue);
            var y = await DbQuery.instanace
                .getTasksBySignedInUser(_auth.currentUser?.email);
            print(y[0].data());
            print(newValue);
            setState(() {
              bucketValue = newValue!;
              usersDeptArray = x;
            });
          },
          items: bucketDropDownItems),
    ],
  );

  Widget selectUser() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Select User", style: TextStyle(fontSize: 18)),
      const SizedBox(height: 5.0),
      DropdownButtonFormField(
          hint: const Text(
            "Select User",
            style: TextStyle(color: Colors.black),
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            filled: false,
            fillColor: Colors.black,
          ),
          validator: (value) => value == null ? "Select User" : null,
          dropdownColor: Colors.grey,
          value: assignedToUserName,
          onChanged: (String? newValue) {
            setState(() {
              assignedToUserName = newValue!;
            });
          },
          items: usersDeptArray.map((val) {
            print("val is $val");
            return DropdownMenuItem(
                child: Text("${val['displayName']}"),
                value: "${val['displayName']}");
          }).toList()),
    ],
  );
}
