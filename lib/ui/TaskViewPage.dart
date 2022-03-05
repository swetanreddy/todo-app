import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeline_tile/timeline_tile.dart';
import 'package:todo/model/task.dart';
import 'package:todo/startup.dart';
import 'package:todo/ui/HomePage.dart';
import 'package:todo/ui/TaskEditPage.dart';
import 'package:todo/ui/TaskHomePage.dart';
import 'package:todo/theme.dart';

class TaskViewPage extends StatefulWidget {
  Task? task;

  TaskViewPage({Key? key, this.task}) : super(key: key);

  @override
  _TaskViewPageState createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController = TextEditingController();
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    // TODO: implement initState
    // TabController _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Image(
                      height: 35,
                      width: 35,
                      image: AssetImage('assets/images/backarrow.png',),
                    ),
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const startUpPage()));}
                    ),
                  Text('Task Details',style: kHeadingFont.copyWith(color: black,fontSize: 14),),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const TaskEditPage()));
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
                          "${widget.task?.title}",
                          style: kTitleFont.copyWith(fontSize: 22)
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.task?.tag}",
                            style: kHeadingFont.copyWith(fontSize: 12),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "Priority: ${widget.task?.priority}",
                            style: kHeadingFont.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(vertical: 4),
                      //       child: Container(
                      //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(15),
                      //           color: primary,
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.5),
                      //           child: Text(
                      //             "${widget.task?.tag}",
                      //             style: const TextStyle(color: Colors.white),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Text(
                      //       "${timeago.format(widget.task!.datetime!)}",
                      //       style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 15,
                      ),
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
                                        child: Text("Swetan",style: kHeadingFont.copyWith(color: black,fontSize: 13.5),),),
                                    ],
                                  )


                                ],
                              )),
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
                                  )


                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Text('Description',style: kHeadingFont.copyWith(color: black,fontSize: 14),),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Of course, deeply understanding your users and their needs is the foundation"
                              " of any food product. But that also means understanding all types of users"
                              "and cases",
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
                            labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                            unselectedLabelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                            tabs: [
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
                      // Text(
                      //   "Comments",
                      //   style: kHeadingFont.copyWith(color: black,fontSize: 14)
                      // ),
                      // const SizedBox(
                      //   height: 58,
                      // ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         Icons.chat,
                      //         size: 32,
                      //         color: Colors.grey[300],
                      //       ),
                      //       const SizedBox(
                      //         height: 8,
                      //       ),
                      //     Text(
                      //         "Leave the first comment",
                      //         style: kHeadingFont.copyWith(color: Colors.grey,fontSize: 13),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
                flex: 20),
            // Expanded(
            //     child: PhysicalModel(
            //       color: Colors.grey,
            //       elevation: 2,
            //       child: Container(
            //         color: Colors.grey[200],
            //         padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            //         child: Row(
            //           children: [
            //             Expanded(
            //                 child: TextField(
            //                   controller: _textEditingController,
            //                   decoration: const InputDecoration(
            //                       border: InputBorder.none,
            //                       hintText: "Add a comment...",
            //                       hintStyle: TextStyle(color: Colors.black54)),
            //                 )),
            //             IconButton(
            //                 onPressed: () {
            //                   if (_textEditingController.text.length > 0) {
            //                     print(_textEditingController.text);
            //                   }
            //                 },
            //                 icon: const Icon(Icons.send)),
            //           ],
            //         ),
            //       ),
            //     ),
            //     flex: 2),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 22,right: 22, bottom: 8.0),
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
            )
          ],
        ),
      ),
    );
  }

  Widget comments() => SingleChildScrollView(
    child: Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Comments",
                  style: kHeadingFont.copyWith(color: black,fontSize: 14)
              ),
            ),
            const SizedBox(
              height: 58,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat,
                    size: 32,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Leave the first comment",
                    style: kHeadingFont.copyWith(color: Colors.grey,fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );


  Widget timeline() => SingleChildScrollView(
    child: Container(
      height: 300,
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
          ]
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
