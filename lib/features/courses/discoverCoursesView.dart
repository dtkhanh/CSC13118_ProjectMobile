import 'package:flutter/material.dart';
import '../../data/data.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:csc13118_mobile/features/homepage/homeView.dart';
import 'package:csc13118_mobile/features/schedule/scheduleView.dart';
import 'package:csc13118_mobile/features/history/historyView.dart';
import 'InformationCourse.dart';

class DiscoverCourses extends StatefulWidget {
  const DiscoverCourses({Key? key}) : super(key: key);


  @override
  State<DiscoverCourses> createState() => _DiscoverCoursesViewStage();
}

class _DiscoverCoursesViewStage extends State<DiscoverCourses> {
  int chosenFilter = 0;
  String dropdownValue = 'One'; // Giá trị mặc định ban đầu

  List<Widget> pages = [
    const HomeView(),
    const ScheduleView(),
    const historyView(),
  ];


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
                    'assets/images/images.png',
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
                          'Discover Courses',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: MediaQuery.of(context).size.width //
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              hintText: 'Course',
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13,),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  "Live Tutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.",
                   style: TextStyle( fontSize: 14)
                ),
              ),
              Column(
                children: <Widget>[
                  ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(md:3 ,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                            child:  SizedBox(
                              height: 30,
                              child:  DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                  hintText: 'Select level',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13, ),
                                ),
                                onChanged: (value) {}, items: const [],
                              ),
                            ),
                          ),
                      ),
                      ResponsiveGridCol(md:3 ,child:  Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                        child:  SizedBox(
                          height: 30,
                          child:  DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              hintText: 'Select Category',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 13, ),
                            ),
                            onChanged: (value) {}, items: const [],
                          ),
                        ),
                      ),),
                      ResponsiveGridCol(md:3 ,child:  Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                        child:  SizedBox(
                          height: 30,
                          child:  DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              hintText: 'Sort by level',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 13, ),
                            ),
                            onChanged: (value) {}, items: const [],
                          ),
                        ),
                      ),),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 24, 12),
                child:  Wrap(
                  spacing: 9,
                  runSpacing: 6,
                  children: List<Widget>.generate(
                    schedule.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              chosenFilter = index;
                            });
                          },
                          child:  Text(
                            schedule[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: chosenFilter == index ? Colors.blue[700] : Colors.black,
                            ),
                          ),

                        ),
                  ),
                ),
              ),

              Padding(
                padding: const  EdgeInsets.fromLTRB(0, 20, 12, 12),
                child: Container(
                  height: 1,
                  decoration:  BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 24, 12),
                child: chosenFilter ==0 ?  Row(
                  children: const [
                    Text(
                      'English For Traveling',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                    ),
                  ],
                ) :  Row(
                  children: const [
                  ],
                ),
              ),


              Center(
                child:  chosenFilter == 0 ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                  child:  Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: List<Widget>.generate(
                        filters.length,
                            (index) => SizedBox(
                            child:GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const InformationCourseView()),
                                );
                              },
                              child: SizedBox(
                                  width: 320,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0), // Set border radius
                                    ),
                                    surfaceTintColor: Colors.white,
                                    elevation: 3.0,
                                    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200, // set the height of the container
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),// Set border radius
                                            image: DecorationImage(
                                              image: AssetImage('assets/images/english.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: const [
                                                SizedBox(height: 10),
                                                Text(
                                                  'Life in the Internet Age',
                                                  style: TextStyle(
                                                      fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Let is discuss how technology is changing the way we live',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 13.0, color: Colors.grey, height: 1.6
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Text(
                                                  'Intermediate - 9 Lessons',
                                                  style: TextStyle(
                                                      fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ],

                                            )
                                        )
                                      ],
                                    ),

                                  )
                              )
                            ),
                        )
                    ),
                  ),
                ) : chosenFilter == 1 ? const Text(
                  'Course',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                ) : const Text(
                  'Interactive E-book',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
