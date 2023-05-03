import 'package:flutter/material.dart';
import '../../../data/data.dart';
import '../../../model/course/course.dart';
import '../InformationCourse.dart';


class CardCourse extends StatefulWidget {
  final Course course;
  const CardCourse({super.key, required this.course});

  @override
  State<CardCourse> createState() => _CardCourseStage();

}

class _CardCourseStage extends State<CardCourse> {
  int rate = 5;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),// S
                        // et border radius
                        image: DecorationImage(
                          image: NetworkImage( widget.course.imageUrl ??'assets/images/english.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              widget.course.name ?? "",
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.course.description ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13.0, color: Colors.grey, height: 1.6
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${courseLevels[widget.course.level!]} -  ${widget.course.topics!.length} lessons',
                              style: const TextStyle(
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
    );
  }
}

