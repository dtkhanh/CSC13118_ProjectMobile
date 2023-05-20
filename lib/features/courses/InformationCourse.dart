import 'package:csc13118_mobile/features/courses/topicDetail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/data.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../../model/course/course.dart';
import '../../services/courseService.dart';

class InformationCourseView extends StatefulWidget {
  final String idCourse;
  const InformationCourseView({super.key, required this.idCourse});


  @override
  State<InformationCourseView> createState() => _InformationCourseViewStage();
}

class _InformationCourseViewStage extends State<InformationCourseView> {
  int chosenFilter = 0;
  late final Course courseDetail;

  bool _isLoading = false;

  Future<void> _fetchCourseDetail() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    final result = await CourseService.getCourseDetail(
      token: check!,
      id: widget.idCourse,
    );
    setState(() {
      courseDetail = result;
      _isLoading = true;
    });
    // try{
    // }catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Error : ${e.toString()}')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    _fetchCourseDetail();
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
          child:   !_isLoading
              ?
          const Center(
            child: Text(
              'NO DATA',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
            ),
          )
              :
          Column(
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
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),// Set border radius
                                  image: DecorationImage(
                                    image: NetworkImage( courseDetail.imageUrl ??'assets/images/english.png'),
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
                                      Text(
                                        courseDetail.name ?? "",
                                        style: const TextStyle(
                                            fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        courseDetail.description ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 13.0, color: Colors.grey, height: 1.6
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) =>   TopicDetail(topic: 0,courseDetail: courseDetail,)),
                                            );
                                          },
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
                              padding: const EdgeInsets.fromLTRB(0, 25, 0,5),
                              child:   Row(
                                children: const [
                                  Icon(Icons.help_outline, color: Colors.red),
                                  SizedBox(
                                      width: 5),
                                  Text(
                                    'Why take this course',
                                    style: TextStyle(
                                      fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0,5),
                              child:  Text(
                                courseDetail.reason ?? "",
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0,5),
                              child:   Row(
                                children: const [
                                  Icon(Icons.help_outline, color: Colors.red),
                                  SizedBox(
                                      width: 5),
                                  Text(
                                    'What will you be able to do',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0,5),
                              child:  Text(
                                courseDetail.purpose ?? "",
                                    style: const TextStyle(
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
                              padding: const EdgeInsets.fromLTRB(0, 25, 0,5),
                              child:   Row(
                                children: [
                                  const Icon(Icons.auto_fix_normal, color: Colors.blue),
                                  const SizedBox(
                                      width: 5),
                                  Text(
                                    courseLevels[courseDetail.level ?? '0'] ?? "",
                                    style: const TextStyle(
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
                              padding: const EdgeInsets.fromLTRB(0, 25, 0,5),
                              child:   Row(
                                children: [
                                  const Icon(Icons.topic_outlined, color: Colors.blue),
                                  const SizedBox(
                                      width: 5),
                                  Text(
                                    courseDetail.topics == null ? "" : '${courseDetail.topics?.length}  Topics',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            courseDetail.topics == null
                            ?
                            const Text(
                              "",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500
                              ),
                            )
                            :
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
                              child: Expanded(
                                child: Column(
                                  children: List<Widget>.generate(
                                    courseDetail.topics?.length ?? 0,
                                        (index) =>SizedBox(
                                          width: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                                            child:
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>   TopicDetail(topic: index,courseDetail: courseDetail,)),
                                                  );
                                                },
                                                child:  Card(
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
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Text(
                                                                '${index +1}',
                                                                style: const TextStyle(
                                                                  fontSize: 15, color: Colors.black,
                                                                ),
                                                              ),
                                                              Text(
                                                                courseDetail.topics![index].name ?? "",
                                                                style: const TextStyle(
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
                                          ),
                                        )
                                  ),
                                )
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
