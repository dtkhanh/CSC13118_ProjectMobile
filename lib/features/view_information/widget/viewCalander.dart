import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../model/schedule/schedule.dart';
import '../../../model/tutor/feedback.dart';
import '../../../services/scheduleService.dart';
import '../../tutors/widget/viewRatting.dart';

class ViewCalender extends StatefulWidget {
  final String idTutors;
  const ViewCalender({super.key, required this.idTutors});

  @override
  State<ViewCalender> createState() => _ViewCalenderStage();

}

class _ViewCalenderStage extends State<ViewCalender> {
  List<Schedule>? listSchedule;
  bool checkData = false;
  final _noteText = TextEditingController();



  List<Appointment> getAppointments() {
    List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));
    DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    DateTime endTime = DateTime(today.year, today.month, today.day, 12, 0, 0);
    for( int i =0 ;i< listSchedule!.length ; i++){
      print(DateTime.fromMillisecondsSinceEpoch(listSchedule![i].startTimestamp ?? 0),);
      meetings.add(
          Appointment(
              startTime: DateTime.fromMillisecondsSinceEpoch(listSchedule![i].startTimestamp ?? 0),
              endTime: DateTime.fromMillisecondsSinceEpoch(listSchedule![i].endTimestamp ?? 0),
              subject: 'Metting' ,
              id: '${listSchedule![i].isBooked}|${listSchedule![i].scheduleDetails?.first.id.toString() ?? ""}|${listSchedule![i].startTime}|${listSchedule![i].endTime}' ,
              color: listSchedule![i].isBooked == true ? Colors.grey : Colors.blue,
              recurrenceRule: null,
              isAllDay: false)
      );
    }

    return meetings;
  }
  Future<void> _fetchTutorSchedule(String id) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      listSchedule = await ScheduleService.getScheduleByTutorId( token: check!, userId: id);
      listSchedule = listSchedule?.where((schedule) {
        if (schedule.startTimestamp == null) return false;
        final start = DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
        return start.isAfter(DateTime.now());
      }).toList();
      setState(() {
        checkData = true;
      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Schedule: ${e.toString()}')),
      );
    }
  }

  Future<void> _dialogBuilder(String startTime, String endTime, String id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.grey.shade200,
          title: const Text('Booking details' ,  style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Booking time',
                  style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$startTime - $endTime',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Note',
                  style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _noteText,
                    minLines: 3,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: '',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
                onPressed: () async {
                  try{
                    final prefs = await SharedPreferences.getInstance();
                    String? check =  prefs.getString('accessToken');
                    await ScheduleService.booking(
                      scheduleDetailIds: [id ?? ''],
                      note: _noteText.text,
                      token: check!,
                    );
                    setState(() {
                      checkData = true;
                    });
                    Navigator.pop(context);

                  }catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error Schedule: ${e.toString()}')),
                    );
                  }
                },
                child: const Text('BOOK', style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold),)),
          ],
        );
      },
    );
  }
  Future<void> BookCalender(String schedule) async {
      final list = schedule.split('|').toList();
      print(schedule);
      if(list[0] == "false"){
        _dialogBuilder(list[2],list[3],list[1], );
      }
  }

  @override
  Widget build(BuildContext context) {
    _fetchTutorSchedule(widget.idTutors.toString() ?? "");
    return Expanded(
      child: !checkData
          ?
      const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
      )
      :
      Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set border radius
          ),
          surfaceTintColor: Colors.white,
          elevation: 3.0,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: SizedBox(
            height: 500,
            child: SfCalendar(
              // headerHeight: 5,
              view: CalendarView.week,
              firstDayOfWeek: 7,
              // initialDisplayDate: DateTime.now(),
              //initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
              dataSource: MeetingDataSource(getAppointments()),
              appointmentTimeTextFormat: 'hh:mm a',
              monthViewSettings: MonthViewSettings(showAgenda: true),
              showDatePickerButton: true,
              headerHeight: 60,
              viewHeaderHeight: 70,
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.appointment) {
                  final Appointment appointmentDetails = details.appointments![0];
                  BookCalender(appointmentDetails.id.toString());
                }
              },
            ),
          )

      )
    );
  }
}
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}


