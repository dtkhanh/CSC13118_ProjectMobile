import 'package:csc13118_mobile/features/courses/widget/CardCourse.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/data.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:csc13118_mobile/features/homepage/homeView.dart';
import 'package:csc13118_mobile/features/schedule/scheduleView.dart';
import 'package:csc13118_mobile/features/history/historyView.dart';
import '../../model/course/course.dart';
import '../../services/courseService.dart';

class DiscoverCourses extends StatefulWidget {
  const DiscoverCourses({Key? key}) : super(key: key);


  @override
  State<DiscoverCourses> createState() => _DiscoverCoursesViewStage();
}

class _DiscoverCoursesViewStage extends State<DiscoverCourses> {
  int chosenFilter = 0;
  String dropdownValue = 'One'; // Giá trị mặc định ban đầu
  List<Course> listCourse = [];
  bool checkData = false;

  List<Widget> pages = [
    const HomeView(),
    const ScheduleView(),
    const historyView(),
  ];

  void getListCourse() async {
    try{
      // setState(() {
      //   checkData = false;
      // });
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      if(chosenFilter == 0){
        listCourse = await CourseService.getListCourse(token: check!);
      }else if(chosenFilter ==1){
        listCourse = await CourseService.getListCourseE_book(token: check!);
      }else if(chosenFilter ==2){
        listCourse = await CourseService.getListCourse_Interactive_Ebook(token: check!);
      }
      setState(() {
        checkData = true;
      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : ${e.toString()}')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    getListCourse();
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
                              setState(() {
                                checkData = false;
                                listCourse =[];
                              });
                              getListCourse();
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

              !checkData
                  ?
              const Center(
                child: Text(
                  'NO DATA',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
                ),
              )
                  :

              Center(
                child:  chosenFilter == 0 ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                  child:  Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: List<Widget>.generate(
                        listCourse.length,
                            (index) => CardCourse(course: listCourse[index],)
                    ),
                  ),
                ) : chosenFilter == 1 ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                  child:  Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: List<Widget>.generate(
                        listCourse.length,
                            (index) => CardCourse(course: listCourse[index],)
                    ),
                  ),
                ) : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                  child:  Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: List<Widget>.generate(
                        listCourse.length,
                            (index) => CardCourse(course: listCourse[index],)
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
