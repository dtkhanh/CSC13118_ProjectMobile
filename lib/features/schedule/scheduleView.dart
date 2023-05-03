import 'package:csc13118_mobile/features/schedule/widget/cardSchedule.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/schedule/bookingInfo.dart';
import '../../services/scheduleService.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key? key}) : super(key: key);


  @override
  State<ScheduleView> createState() => _ScheduleViewStage();
}

class _ScheduleViewStage extends State<ScheduleView> {
  int chosenFilter = 0;
  String dropdownValue = 'One';
  List<BookingInfo> listBookClass = [];
  bool checkData = false;


  void getListBooking() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      listBookClass = await ScheduleService.getListClassBooking(token: check!, page: 1, perPage: 20);
      setState(() {
        checkData = true;
      });
      print(listBookClass);
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getListBooking();
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
                child:  !checkData
                    ?
                const Center(
                  child: Text(
                    'NO DATA',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
                  ),
                )
                :
                Wrap(
                  spacing: 6,
                  runSpacing: 8,
                  children: List<Widget>.generate(
                      listBookClass.length,
                          (index) =>  SizedBox(
                          child: CardSchedule(booking: listBookClass[index])
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
