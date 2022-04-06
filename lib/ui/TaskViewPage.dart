import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:todo/model/taskData.dart';
import 'package:todo/ui/TaskEdit.dart';
import 'package:todo/ui/startup.dart';
import 'package:todo/ui/TaskEditPage.dart';
import 'package:todo/helpers/theme.dart';

class TaskViewPage extends StatefulWidget {


  TaskViewPage({Key? key, this.taskData, this.taskId}) : super(key: key);
  final taskData;
  final taskId;
  @override
  _TaskViewPageState createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Image(
                      height: 35,
                      width: 35,
                      image: AssetImage('assets/images/backarrow.png',),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    }
                    ),
                  Text('Task Details',style: kHeadingFont.copyWith(color: black,fontSize: 14),),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      print(widget.taskData);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => EditTask(taskDetails: widget.taskData, taskId : widget.taskId)));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22,right:22, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16,bottom: 5),
                        child: Text(
                          "${widget.taskData['task_title']}",
                          style: kTitleFont.copyWith(fontSize: 22)
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.taskData['dept']}",
                            style: kHeadingFont.copyWith(fontSize: 12),
                          ),
                          const SizedBox(width: 20,),
                          Text(
                            "Priority: ${widget.taskData['priority']}",
                            style: kHeadingFont.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(radius: 20,child: Icon(Icons.person,color: white,size: 18,),),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0,top: 1),
                                      child:  Text("Assigned To",style: kHeadingFont.copyWith(fontSize: 11),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0,top: 1),
                                      child: Text(widget.taskData['to_name'],style: kHeadingFont.copyWith(color: black,fontSize: 13.5),),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(radius: 20,child: Icon(Icons.calendar_today_rounded,color: white,size: 18,),),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0,top: 1),
                                      child:  Text("Due date",style: kHeadingFont.copyWith(fontSize: 11),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0,top: 1),
                                      child: Text("March 2",style: kHeadingFont.copyWith(color: black,fontSize: 13.5),),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Text('Description',style: kHeadingFont.copyWith(color: black,fontSize: 14),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "${widget.taskData['task_desc']}",
                          style:kDescFont,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 24,
                      ),
                      DefaultTabController(
                        length: 2,
                        child: Container(
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: Colors.black,
                            labelStyle: const TextStyle(fontSize: 14.0, color: Colors.black),
                            unselectedLabelStyle: const TextStyle(fontSize: 14.0, color: Colors.black),
                            tabs: const [
                              Tab(child: Text("Comments", style: TextStyle(color: Colors.black),),),
                              Tab(child: Text("Timeline", style: TextStyle(color: Colors.black),),)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            comments(),
                            timeline()
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              flex: 20,
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 22,right: 22, bottom: 8.0),
              child: GestureDetector(
                onTap: () {
                  CollectionReference tasks = FirebaseFirestore.instance.collection('spark_assignedTasks');
                  tasks.doc(widget.taskId).update({"status": "Done"}).then((value) => "Print Task status updated to Done!");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const startUpPage()));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget comments() => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Comments",
                style: kHeadingFont.copyWith(color: black,fontSize: 14)
            ),
            SizedBox(
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.chat,
                      size: 32,
                      color: Colors.grey[300],
                    ),
                    Text(
                      "Leave the first comment",
                      style: kHeadingFont.copyWith(color: Colors.grey,fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        maxLines: 1,
                        controller: _commentController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add a comment...",
                            hintStyle: TextStyle(color: Colors.black54)),
                      )),
                  IconButton(
                      onPressed: () {
                        if (_commentController.text.isNotEmpty) {
                          print(_commentController.text);
                        }
                      },
                      icon: const Icon(Icons.send)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget timeline() => SingleChildScrollView(
    child: SizedBox(
      height: 350,
      child: Center(
        child: ListView(
          children: [
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isFirst: true,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Colors.black,
                padding: EdgeInsets.all(6),
              ),
              endChild: const _RightChild(
                title: 'Created on',
                message: 'Admin created task on 25-feb',
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.black,
              ),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Colors.black,
                padding: EdgeInsets.all(6),
              ),
              endChild: const _RightChild(
                title: 'Assigned to',
                message: 'Task has been assigned from user1 to \nuser2',
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.black,
              ),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Colors.black,
                padding: EdgeInsets.all(6),
              ),
              endChild: const _RightChild(
                title: 'Attachmenmts',
                message: 'User 2 added attachments',
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.black,
              ),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isLast: true,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Colors.black,
                padding: EdgeInsets.all(6),
              ),
              endChild: const _RightChild(
                title: 'Done',
                message: 'Task was done before due date. \nCompleted on feb 28.',
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


class _RightChild extends StatelessWidget {
  const _RightChild({
    Key? key,
    required this.title,
    required this.message,
    this.disabled = false,
  }) : super(key: key);

  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFBABABA)
                      : const Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFD5D5D5)
                      : const Color(0xFF636564),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
}
