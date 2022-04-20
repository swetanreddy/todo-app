import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/helpers/firebase_help.dart';
import 'package:todo/helpers/theme.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  String selected = 'All';
  bool _isSelected = false;

  var selectedUser = '';
  String searchText = '';
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  @override
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
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff00B98D),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      onTap: () {
                        // widget.setPageViewerFun();
                        Navigator.of(context).pop();
                      }),
                  Text(
                    'REPORTS',
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
                'Department',
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
                          selected = 'All';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: selected == 'All' ? primary : Colors.white,
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
                          'All',
                          style: kHeadingFont.copyWith(
                              color: selected == 'All' ? Colors.white : primary,
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
                          selected = 'CRM';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: selected == 'CRM' ? primary : Colors.white,
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
                          'CRM',
                          style: kHeadingFont.copyWith(
                              color: selected == 'CRM' ? Colors.white : primary,
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
                          selected = 'HR';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: selected == 'HR' ? primary : Colors.white,
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
                          'HR',
                          style: kHeadingFont.copyWith(
                              color: selected == 'HR' ? Colors.white : primary,
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
                          selected = 'Legal';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: selected == 'Legal' ? primary : Colors.white,
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
                          'Legal',
                          style: kHeadingFont.copyWith(
                              color:
                                  selected == 'Legal' ? Colors.white : primary,
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
                          selected = 'Sales';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: selected == 'Sales' ? primary : Colors.white,
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
                          'Sales',
                          style: kHeadingFont.copyWith(
                              color:
                                  selected == 'Sales' ? Colors.white : primary,
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
                          selected = 'AdminTeam';
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: selected == 'AdminTeam'
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
                          'Admin Team',
                          style: kHeadingFont.copyWith(
                              color: selected == 'AdminTeam'
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
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
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

              Expanded(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: StreamBuilder<QuerySnapshot>(
                    stream:
                        DbQuery.instanace.getEmployeesByDept('users', selected),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ${snapshot.error}');
                      }
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.active) {
                        print(
                            '==>what is length of  ${snapshot.data?.docs.length}');
                        if (snapshot.data?.docs.length == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'No Data',
                                  style: kHeadingFont.copyWith(color: black),
                                ),
                              ],
                            ),
                          );
                        }
                        var sortedSnap = snapshot.data?.docs;
                        if (searchText.length > 0) {
                          sortedSnap = sortedSnap?.where((element) {
                            return element
                                .get('name')
                                .toString()
                                .toLowerCase()
                                .contains(searchText.toLowerCase());
                          }).toList();
                        }

                        // sortedSnap?.sort((a, b) =>
                        //     int.parse(a['matchDetails']['date'])
                        //         .compareTo(int.parse(b['matchDetails']['date'])));

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, left: 2),
                          child: Column(
                            children: [
                              //  add banner

                              // _enabled ? dummyListViewCell() : Container(),

                              // for (var contestTitle in [
                              //   // "series",
                              //   "matches"
                              // ].toSet().toList())
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0, left: 8, right: 8),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: sortedSnap?.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // DocumentSnapshot ds =
                                        //     snapshot.data
                                        //         .docs[index];
                                        // _enabled = false;
                                        var ds = sortedSnap![index];
                                        // var type;
                                        // try {
                                        //   type = ds['type'] ?? 'matches';
                                        // } catch (e) {
                                        //   type = 'matches';
                                        // }
                                        var name = ds['name'] != null
                                            ? ds['name']
                                            : null;

                                        var roles = ds
                                                .data()
                                                .toString()
                                                .contains('roles')
                                            ? ds['roles']
                                            : ['no dept'];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: (GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedUser = ds['name'];
                                                });
                                                // widget.assignedToDetailsFun(ds);
                                                // widget.setPageViewerFun();
                                              },
                                              // child: type ==
                                              //         'series'
                                              //     ? seriesCard(
                                              //         ds)
                                              //     : matchCard(
                                              //         ds),

                                              child: LabeledCheckbox(
                                                label: '${name}',
                                                roles: roles,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0.0,
                                                        vertical: 10),
                                                value:
                                                    selectedUser == ds['name'],
                                                // onChanged: (bool newValue) {
                                                //   setState(() {
                                                //     _isSelected = newValue;
                                                //   });
                                                // },
                                              )
                                              // child: homeTeamCardW('started', false, false,  ds['matchDetails']['team_1_pic'],ds['matchDetails']['team_2_pic'], ds['matchDetails']['team-1'],ds['matchDetails']['team-2'],ds['matchDetails']['date'],ds['matchDetails']['dispTitle'] )
                                              )),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      // return ShimmerWidgetMatch();
                      return Text(
                        'No Data',
                        style: kHeadingFont.copyWith(color: black),
                      );
                    },
                  ),
                ),
              )
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
    required this.roles,
    required this.padding,
    required this.value,
    //  this.onChanged,
  }) : super(key: key);

  final String label;
  final roles;
  final EdgeInsets padding;
  final bool value;
  // final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: kHeadingFont.copyWith(color: black),
                  ),
                  Text(
                    roles[0],
                    style: kSubTitleFont.copyWith(color: black),
                  ),
                ],
              ),
            )),
            Text("Done 10/12")
          ],
        ),
      ),
    );
  }
}
