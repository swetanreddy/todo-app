import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:todo/model/task.dart';
import 'package:todo/startup.dart';
import 'package:todo/ui/CreateTask.dart';
import 'package:todo/ui/HomePage.dart';
import 'package:todo/ui/TaskEditPage.dart';
import 'package:todo/ui/TaskHomePage.dart';
import 'package:todo/theme.dart';

class SelectMember extends StatefulWidget {
  const SelectMember({Key? key}) : super(key: key);

  @override
  _SelectMemberState createState() => _SelectMemberState();
}

class _SelectMemberState extends State<SelectMember> {
  @override
  String selected = '';
  bool _isSelected = false;
  TextEditingController _textEditingController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      child: Image(
                        height: 20,
                        width: 20,
                        image: AssetImage(
                          'assets/images/backarrow.png',
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => const CreateTask()));
                      }),
                  Text(
                    'Select Members',
                    style: kHeadingFont.copyWith(color: black, fontSize: 14),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Category',
                style: kHeadingFont.copyWith(color: black, fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 'Design';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color:
                                selected == 'Design' ? primary : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              )
                            ]),
                        child: Center(
                            child: Text(
                          'Design',
                          style: kHeadingFont.copyWith(
                              color:
                                  selected == 'Design' ? Colors.white : primary,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 'Meeting';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color:
                                selected == 'Meeting' ? primary : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              )
                            ]),
                        child: Center(
                            child: Text(
                          'Meeting',
                          style: kHeadingFont.copyWith(
                              color: selected == 'Meeting'
                                  ? Colors.white
                                  : primary,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 'Coding';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color:
                                selected == 'Coding' ? primary : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              )
                            ]),
                        child: Center(
                            child: Text(
                          'Coding',
                          style: kHeadingFont.copyWith(
                              color:
                                  selected == 'Coding' ? Colors.white : primary,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 'BDE';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: selected == 'BDE' ? primary : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              )
                            ]),
                        child: Center(
                            child: Text(
                          'BDE',
                          style: kHeadingFont.copyWith(
                              color: selected == 'BDE' ? Colors.white : primary,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 'Testing';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color:
                                selected == 'Testing' ? primary : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              )
                            ]),
                        child: Center(
                            child: Text(
                          'Testing',
                          style: kHeadingFont.copyWith(
                              color: selected == 'Testing'
                                  ? Colors.white
                                  : primary,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 'Quick Call';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: selected == 'Quick Call'
                                ? primary
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              )
                            ]),
                        child: Center(
                            child: Text(
                          'Quick Call',
                          style: kHeadingFont.copyWith(
                              color: selected == 'Quick Call'
                                  ? Colors.white
                                  : primary,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: 'Search',
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              LabeledCheckbox(
                label: 'Ahnaf Irfan',
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                value: _isSelected,
                onChanged: (bool newValue) {
                  setState(() {
                    _isSelected = newValue;
                  });
                },
              ),
              // LabeledCheckbox(
              //   label: 'David Smith',
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
              //   value: _isSelected,
              //   onChanged: (bool newValue) {
              //     setState(() {
              //       _isSelected = newValue;
              //     });
              //   },
              // ),
              // LabeledCheckbox(
              //   label: 'Sami Rafi',
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              //   value: _isSelected,
              //   onChanged: (bool newValue) {
              //     setState(() {
              //       _isSelected = newValue;
              //     });
              //   },
              // ),
              // LabeledCheckbox(
              //   label: 'Mike Jenson',
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
              //   value: _isSelected,
              //   onChanged: (bool newValue) {
              //     setState(() {
              //       _isSelected = newValue;
              //     });
              //   },
              // ),
              // LabeledCheckbox(
              //   label: 'Micheal Scott',
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              //   value: _isSelected,
              //   onChanged: (bool newValue) {
              //     setState(() {
              //       _isSelected = newValue;
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Container(
              height: 43,
              width: 43,
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: kHeadingFont.copyWith(color: black),
              ),
            )),
            Checkbox(
              shape: CircleBorder(),
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
