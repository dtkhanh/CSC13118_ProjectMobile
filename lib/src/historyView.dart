import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:csc13118_mobile/src/InformationTeacher.dart';

class historyView extends StatefulWidget {
  const historyView({Key? key}) : super(key: key);


  @override
  State<historyView> createState() => _HistoryViewStage();
}

class _HistoryViewStage extends State<historyView> {
  int chosenFilter = 0;
  bool _isExpanded = false;

  List<String> _data = [    'Dữ liệu 1',  ];


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
                    'assets/images/callHistory.png',
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
                          'History',
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
                                "The following is a list of lessons you have attended",
                                style: TextStyle(fontSize: 13, height: 1.3)),
                            Text(
                                "You can review the details of the lesons you have attended",
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
                    children: [
                      SizedBox(
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
                                          padding: const EdgeInsets.fromLTRB(24, 5, 24, 5),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Tue, 27 Sep 22',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '6 hours ago ',
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
                                                    MaterialPageRoute(builder: (context) => InforTeacher()),
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
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: const Alignment(0, 0),
                                                color: Colors.grey[100],
                                                child:  Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                  child:
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: const Text(
                                                          'Lession Time: 18:30 - 18:35',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                  ),
                                                ),
                                              const SizedBox(height: 20,),
                                              Container(
                                                alignment: const Alignment(0, 0),
                                                color: Colors.grey[100],
                                                child:  Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                  child:
                                                  Container(
                                                    alignment: Alignment.topLeft,
                                                    child: const Text(
                                                      'No request for lesion',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 2,),
                                              Container(
                                                alignment: const Alignment(0, 0),
                                                color: Colors.grey[100],
                                                child:  Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                  child:
                                                  Container(
                                                    alignment: Alignment.topLeft,
                                                    child: const Text(
                                                      'Tutor have not reviewed yet',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 2,),
                                              Container(
                                                alignment: const Alignment(0, 0),
                                                color: Colors.grey[100],
                                                child:  Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                  child:
                                                  Container(
                                                    alignment: Alignment.topLeft,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                alignment: Alignment.topLeft,
                                                                child: const  Text(
                                                                  'Add a rating',
                                                                  style: TextStyle(
                                                                      color: Colors.blue,
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                alignment: Alignment.topRight,
                                                                child: const  Text(
                                                                  'Report',
                                                                  style: TextStyle(
                                                                      color: Colors.blue,
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          )

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
                                                backgroundColor: Colors.blue, // set the background color of the button
                                              ),
                                              child: Text('Go to meeting', style: TextStyle( color: Colors.white,
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
                      ),
                      SizedBox(
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
                                          padding: const EdgeInsets.fromLTRB(24, 5, 24, 5),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Tue, 27 Sep 22',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '6 hours ago ',
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
                                              const SizedBox(
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
                                          child: Padding(
                                              padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: const Alignment(0, 0),
                                                    color: Colors.grey[100],
                                                    child:  Padding(
                                                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                      child:
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: const Text(
                                                          'Lession Time: 18:30 - 18:35',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  Container(
                                                    alignment: const Alignment(0, 0),
                                                    color: Colors.grey[100],
                                                    child:  Padding(
                                                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                      child:
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: const Text(
                                                          'No request for lesion',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2,),
                                                  Container(
                                                    alignment: const Alignment(0, 0),
                                                    color: Colors.grey[100],
                                                    child:  Padding(
                                                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                      child: Container(
                                                        alignment: Alignment.topLeft,
                                                        child:  Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Container(
                                                                    alignment: Alignment.topLeft,
                                                                    child: const Text(
                                                                      'Review from tutor',
                                                                      style: TextStyle(
                                                                          fontSize: 13,
                                                                          fontWeight: FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Container(
                                                                    alignment: Alignment.topRight,
                                                                    child:InkWell(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          _isExpanded = !_isExpanded;
                                                                        });
                                                                      },
                                                                      child: const Text(
                                                                      'v',
                                                                      style: TextStyle(
                                                                          color: Colors.blue,
                                                                          fontSize: 13,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                    ),
                                                                ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(height: 10,),

                                                            if (_isExpanded)
                                                              Wrap(
                                                                  spacing: 6,
                                                                  runSpacing: 8,
                                                                  children: List<Widget>.generate(
                                                                      _data.length,
                                                                          (index) =>Column(
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                            children: [
                                                                              const Text(
                                                                                'Session1: 22:00 - 22:30',
                                                                                style: TextStyle(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.bold),
                                                                              ),
                                                                              const Text(
                                                                                'Lesson status: Completed 40 page',
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                ),
                                                                              ),
                                                                              const Text(
                                                                                'Lesson Progress: Completed',
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                children: const [
                                                                                  Text(
                                                                                    'Behavier: ',
                                                                                    style: TextStyle(
                                                                                      fontSize: 13,
                                                                                    ),
                                                                                  ),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: const [
                                                                                  Text(
                                                                                    'Listening: ',
                                                                                    style: TextStyle(
                                                                                      fontSize: 13,
                                                                                    ),
                                                                                  ),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: const [
                                                                                  Text(
                                                                                    'Speaking: ',
                                                                                    style: TextStyle(
                                                                                      fontSize: 13,
                                                                                    ),
                                                                                  ),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: const [
                                                                                  Text(
                                                                                    'Vocabulary: ',
                                                                                    style: TextStyle(
                                                                                      fontSize: 13,
                                                                                    ),
                                                                                  ),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                  Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                                                ],
                                                                              ),
                                                                              const Text(
                                                                                'Overall comment: We finished the lesson',
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                  )
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2,),
                                                  Container(
                                                    alignment: const Alignment(0, 0),
                                                    color: Colors.grey[100],
                                                    child:  Padding(
                                                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                                      child:
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Container(
                                                                    alignment: Alignment.topLeft,
                                                                    child: const  Text(
                                                                      'Add a rating',
                                                                      style: TextStyle(
                                                                          color: Colors.blue,
                                                                          fontSize: 13,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Container(
                                                                    alignment: Alignment.topRight,
                                                                    child: const  Text(
                                                                      'Report',
                                                                      style: TextStyle(
                                                                          color: Colors.blue,
                                                                          fontSize: 13,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              )

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
                                                backgroundColor: Colors.blue, // set the background color of the button
                                              ),
                                              child: Text('Go to meeting', style: TextStyle( color: Colors.white,
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
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
