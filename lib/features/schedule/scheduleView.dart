import 'package:csc13118_mobile/features/schedule/widget/cardSchedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  bool render = false;

  List<List<BookingInfo>> groupedItems = [];



  void getListBooking() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      listBookClass = await ScheduleService.getListClassBooking(token: check!, page: 1, perPage: 20);
      List<BookingInfo> currentGroup = [];
      List<List<BookingInfo>> groupedItems_new = [];
      for (int i = 0; i < listBookClass.length ; i++) {
        BookingInfo currentItem = listBookClass[i];
        DateTime currentStartTime = DateTime.fromMillisecondsSinceEpoch(
            currentItem.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
        String currentDateTime = DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
            currentItem.scheduleDetailInfo!.startPeriodTimestamp ?? 0));
        if (currentGroup.isEmpty || currentStartTime.difference(DateTime.fromMillisecondsSinceEpoch(
            currentGroup.last.scheduleDetailInfo?.endPeriodTimestamp ?? 0)).inMinutes <= 5
            && currentDateTime == DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                currentGroup.last.scheduleDetailInfo!.startPeriodTimestamp ?? 0))) {
          currentGroup.add(listBookClass[i]);
        } else {
          groupedItems_new.add(currentGroup);
          currentGroup = [listBookClass[i]];
          if(i == listBookClass.length -1){
            groupedItems_new.add([listBookClass[i]]);
          }
        }
      }
      setState(() {
        groupedItems=groupedItems_new;
        checkData = true;
        render = true;
      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : ${e.toString()}')),
      );
    }
  }
  void renderCall() async {
    setState(() {
      render = false;
    });
    List<List<BookingInfo>> groupedItems_new = [];
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    listBookClass = await ScheduleService.getListClassBooking(token: check!, page: 1, perPage: 20);
    List<BookingInfo> currentGroup = [];
    for (int i = 0; i < listBookClass.length ; i++) {
      BookingInfo currentItem = listBookClass[i];
      DateTime currentStartTime = DateTime.fromMillisecondsSinceEpoch(
          currentItem.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
      if (currentGroup.isEmpty || currentStartTime.difference(DateTime.fromMillisecondsSinceEpoch(
          currentGroup.last.scheduleDetailInfo?.endPeriodTimestamp ?? 0)).inMinutes <= 5 ) {
        currentGroup.add(listBookClass[i]);
      } else {
        groupedItems_new.add(currentGroup);
        currentGroup = [listBookClass[i]];
      }
    }
    setState(() {
      groupedItems = groupedItems_new;
      render = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    getListBooking();
    if(render){
      getListBooking();
    }
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
                child:  !checkData || !render
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
                      groupedItems.length,
                          (index) =>  SizedBox(
                          child: CardSchedule(bookings: groupedItems[index], onPressed: renderCall)
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
