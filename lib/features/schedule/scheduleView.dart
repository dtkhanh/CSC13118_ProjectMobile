import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/data.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:csc13118_mobile/features/view_information/teacher_info/InformationTeacher.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);


  @override
  State<ScheduleView> createState() => _ScheduleViewStage();
}

class _ScheduleViewStage extends State<ScheduleView> {
  int chosenFilter = 0;
  String dropdownValue = 'One'; // Giá trị mặc định ban đầu


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/schedule.png',
                    width: 120, // Chiều rộng của hình ảnh
                    height: 120, // Chiều cao của hình ảnh
                    fit: BoxFit
                        .cover,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Schedule',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: MediaQuery.of(context).size.width //
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                                "Here is a list of the sessions you have booked ",
                                style: TextStyle(fontSize: 13, height: 1.3)),
                            Text(
                                "You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours",
                                style: TextStyle(fontSize: 13, height: 1.3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 8,
                  children: List<Widget>.generate(
                      teachers.length,
                          (index) => SizedBox(
                          child: Card(
                                color: Colors.grey.shade300,
                                surfaceTintColor: Colors.white,
                                elevation: 3.0,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      ResponsiveGridRow(
                                        children: [
                                          ResponsiveGridCol(
                                            md: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    'Fri, 30 Sep 22',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '1 lesson',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ResponsiveGridCol(
                                            md: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                                              child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => const InforTeacher()),
                                                        );
                                                      },
                                                      child: const SizedBox(
                                                        width: 50,
                                                        // Set the width to 100
                                                        height: 50,
                                                        // Set the height to 100
                                                        child: CircleAvatar(
                                                          radius: 45,
                                                          backgroundColor:
                                                          Colors.blue,
                                                          backgroundImage: AssetImage(
                                                              'assets/images/ironman.png'),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            const Text(
                                                              'Keegan',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  "assets/svg/icon.svg",
                                                                  semanticsLabel:
                                                                  'Logo Icon',
                                                                  width: 20,
                                                                  height: 20,
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                const Text("France",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        14)),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            const Text(
                                                              'Direct Message',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                            ),
                                          ),
                                          ResponsiveGridCol(
                                            md: 6,
                                            child:  Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                              child: Container(
                                                alignment: const Alignment(0, 0),
                                                color: Colors.grey[100],
                                                child:  Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Expanded(
                                                            child:  Text(
                                                              '18:30 - 18:35',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                                child: Align(
                                                                  alignment: Alignment.topRight,
                                                                  child: OutlinedButton.icon(
                                                                    onPressed: () => {},
                                                                    icon: const Icon(Icons.cancel , color: Colors.red,),
                                                                    label: const Text('Cancel' , style: TextStyle(color:  Colors.red,),),
                                                                  ),
                                                                ) ,
                                                              )

                                                          ),
                                                          const SizedBox(width: 10),
                                                        ],
                                                      ),
                                                      const SizedBox( height: 10),
                                                      Table(
                                                        border: TableBorder.all(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.grey,
                                                          width: 1,
                                                        ),
                                                        children: [
                                                          TableRow(
                                                            children: [
                                                              TableCell(
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:   DropdownButtonFormField(
                                                                          decoration: const InputDecoration(
                                                                            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                                            hintText: 'Request for lesson',
                                                                            hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                                                                          ),
                                                                          onChanged: (value) {}, items: const [],
                                                                        ),
                                                                      ),
                                                                      const Expanded(
                                                                        child: Align(
                                                                            alignment: Alignment.topRight,
                                                                            child: Text('Edit Request' , style: TextStyle(color:  Colors.blue,)
                                                                            )
                                                                        ),

                                                                      ),
                                                                      const SizedBox(width: 10),
                                                                    ],
                                                                  )
                                                              ),
                                                            ],
                                                          ),
                                                          const TableRow(
                                                            children: [
                                                              TableCell(
                                                                child: Padding(
                                                                  padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                                                                  child: Text('Current there are no requests for this class. Please write down any request for the teacher' , style: TextStyle(color:  Colors.grey, fontSize: 14)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )

                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Positioned(
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.grey[100], // set the background color of the button
                                                  ),
                                                  child: Text('Go to meeting', style: TextStyle( color: Colors.grey[500],
                                                  ),),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              )
                          )
                  )
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
