import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/data.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter_responsive_grid/flutter_responsive_grid.dart';

class InformationCourseView extends StatefulWidget {
  const InformationCourseView({Key? key}) : super(key: key);


  @override
  State<InformationCourseView> createState() => _InformationCourseViewStage();
}

class _InformationCourseViewStage extends State<InformationCourseView> {
  int chosenFilter = 0;
  List<String> _data = [ 'Topic1','Topic1','Topic1','Topic1','Topic1','Topic1','Topic1','Topic1','Topic1','Topic1',  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Course Details',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            //letterSpacing: 1.0,
            color: Colors.blue[600],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child:  Column(
            children: [
              Column(
                children: <Widget>[
                  ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(md:4 ,child: Padding(
                        padding:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                          ),
                          surfaceTintColor: Colors.white,
                          elevation: 3.0,
                          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300, // set the height of the container
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),// Set border radius
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/english-course.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Basic conversation Topics',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Gain confidence speaking about familiar topics',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey, height: 1.6
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue.shade700, // set the background color of the button
                                          ),
                                          child: const Text('Discover', style: TextStyle( color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                    ],
                                  )
                              )

                            ],
                          ),

                        ),
                      )
                      ),
                      ResponsiveGridCol(md:7 ,child:Padding(
                        padding:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(40, 25, 25,0),
                              child: Text(
                                'Overview',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 25, 0,5),
                              child:   Row(
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
                                  const Text(
                                    'Why take this course',
                                    style: TextStyle(
                                      fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 0,5),
                              child:  Text(
                                'In this article, we will discuss why interviewers ask about your course selection, how you can best answer questions about why you chose your course selection and we provide example answers to guide you.',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0,5),
                              child:   Row(
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
                                  const Text(
                                    'What will you be able to do',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 0,5),
                              child:  Text(
                                'In this article, we will discuss why interviewers ask about your course selection, how you can best answer questions about why you chose your course selection and we provide example answers to guide you.',
                                style: TextStyle(
                                  fontSize: 13, color: Colors.black,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(40, 25, 25,0),
                              child: Text(
                                'Experience Level',
                                style: TextStyle(
                                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 25, 0,5),
                              child:   Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/Beginner.svg",
                                    semanticsLabel:
                                    'Logo Icon',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(
                                      width: 5),
                                  const Text(
                                    'Beginner',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(40, 25, 25,0),
                              child: Text(
                                'Course Length',
                                style: TextStyle(
                                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 25, 0,5),
                              child:   Row(
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
                                  const Text(
                                    '10 topic',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(40, 25, 25,0),
                              child: Text(
                                'List Topics',
                                style: TextStyle(
                                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '1.',
                                                        style: TextStyle(
                                                            fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Foods You Love',
                                                        style: TextStyle(
                                                            fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),
                                      const SizedBox( width: 10),
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '2.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Your Job',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),

                                    ],
                                  ),
                                  const SizedBox( height: 10),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '3.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Playing and Watching Sports',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),
                                      const SizedBox( width: 10),
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '4.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'The Best Pet',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),

                                    ],
                                  ),
                                  const SizedBox( height: 10),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '1.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Foods You Love',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),
                                      const SizedBox( width: 10),
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '2.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Your Job',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),

                                    ],
                                  ),
                                  const SizedBox( height: 10),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '1.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Foods You Love',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),
                                      const SizedBox( width: 10),
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '2.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Your Job',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),

                                    ],
                                  ),
                                  const SizedBox( height: 10),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '1.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Foods You Love',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),
                                      const SizedBox( width: 10),
                                      Expanded(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                                          ),
                                          surfaceTintColor: Colors.white,
                                          elevation: 3.0,
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: const [
                                                      SizedBox(height: 10),
                                                      Text(
                                                        '2.',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Your Job',
                                                        style: TextStyle(
                                                          fontSize: 15, color: Colors.black,
                                                        ),
                                                      ),
                                                    ],

                                                  )
                                              )
                                            ],
                                          ),

                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              )
                            ),

                          ],
                        )
                      )

                      ),
                    ],
                  )
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}
