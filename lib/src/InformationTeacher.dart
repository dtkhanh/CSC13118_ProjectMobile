import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../data/data.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class InforTeacher extends StatefulWidget {
  const InforTeacher({Key? key}) : super(key: key);


  @override
  State<InforTeacher> createState() => _InforTeacherState();


}

class _InforTeacherState extends State<InforTeacher> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network('https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4'),
      autoPlay: true,
      looping: true,
    );
  }


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
            'Information Teacher',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              //letterSpacing: 1.0,
              color: Colors.blue[600],
            ),
          ),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child:  Column(
              children: [
                Column(
                  children: <Widget>[
                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(md:6 ,child: Padding(
                          padding:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 45,
                                    backgroundImage: AssetImage('assets/images/ironman.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Keegan", style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),),
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
                                            const Text("France", style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                        Row(children: [
                                          Row(
                                            children: const <Widget>[
                                              Icon(Icons.star, color: Colors.yellow, size: 15,),
                                              Icon(Icons.star, color: Colors.yellow,size: 15,),
                                              Icon(Icons.star, color: Colors.yellow,size: 15,),
                                              Icon(Icons.star_half, color: Colors.yellow,size: 15,  ),
                                              Icon(Icons.star_border, color: Colors.yellow,size: 15),
                                            ],
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('58',
                                              style: TextStyle(fontSize: 18))
                                        ])
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(   'I am passionate about running and fitness, '
                                    'I often compete in trail/mountain running events and I love pushing myself. '
                                    'I am training to one day take part in ultra-endurance events. '
                                    'I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. '
                                    'My most memorable life experience would be living in and traveling around Southeast Asia.',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14)),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                      },
                                      child: Column(
                                        children: const [
                                          Icon(
                                              Icons.favorite ,
                                              color:  Colors.red
                                          ),
                                          Text( 'Favorite', style: TextStyle(color:  Colors.red ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                      },
                                      child: Column(
                                        children: const [
                                          Icon(Icons.reviews_outlined, color: Colors.blue),
                                          Text('Review', style: TextStyle(color: Colors.blue))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () async {
                                      },
                                      child: Column(
                                        children: const [
                                          Icon(Icons.report_outlined, color: Colors.blue),
                                          Text('Report', style: TextStyle(color: Colors.blue))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                        ),
                        ResponsiveGridCol(md:6 ,child:Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                          ),
                          surfaceTintColor: Colors.white,
                          elevation: 3.0,
                          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(
                                height: 250, // set the height of the container
                                child: Chewie(
                                  controller: _chewieController,
                                ),
                              ),
                            ],
                          ),

                        )

                        ),
                      ],
                    ),
                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(md:5 ,child: Padding(
                          padding:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Languages',  style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor : Colors.lightBlue[100] , // set the background color of the button
                                  ),
                                  child: Text( 'English', style: TextStyle( color:Colors.blue[700] ,
                                  ),),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Specialties',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: List<Widget>.generate(
                                  testData.length,
                                      (index) => Positioned(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor :  Colors.lightBlue[100]  // set the background color of the button
                                      ),
                                      child: Text( filters[index], style: TextStyle( color: Colors.blue[700],
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Suggested Courses',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(5, 20, 0, 0),
                                child: Row(
                                  children: const [
                                    Text('Basic Conversation Topics:',  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),),
                                    Text(' Link',  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),),

                                  ],
                                ),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(5, 20, 0, 0),
                                child: Row(
                                  children: const [
                                    Text('Life in the internet Age:',  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),),
                                    Text(' Link',  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),),

                                  ],
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('interests:',  style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                child: Row(
                                  children: const [
                                    Expanded(child: Text('I loved the weather, the scenery and the laid-back lifestyle of the locals',  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),),)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Teaching experience',  style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                child: Row(
                                  children: const [
                                    Expanded(child: Text('I have more than 10 years of teaching english experience',  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),),)
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )
                        ),
                        ResponsiveGridCol(md:7 ,child:Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                          ),
                          surfaceTintColor: Colors.white,
                          elevation: 3.0,
                          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: SizedBox(
                            height: 500,
                            child: SfCalendar(
                              headerHeight: 10,
                              view: CalendarView.week,
                              firstDayOfWeek: 6,
                              //initialDisplayDate: DateTime(2021, 03, 01, 08, 30),
                              //initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
                              dataSource: MeetingDataSource(getAppointments()),
                            ),
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
      )
    );
  }
}
List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  // final DateTime endTime = startTime.add(const Duration(hours: 2));
  // meetings.add(Appointment(
  //     startTime: startTime,
  //     endTime: endTime,
  //     subject: 'Board Meeting',
  //     color: Colors.blue,
  //     recurrenceRule: 'FREQ=DAILY;COUNT=10',
  //     isAllDay: false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}