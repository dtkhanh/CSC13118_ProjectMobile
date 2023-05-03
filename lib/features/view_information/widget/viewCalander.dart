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
              subject: listSchedule![i].id ?? "",
              color: listSchedule![i].isBooked == true ? Colors.blue : Colors.grey,
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
      print("_fetchTutorSchedule");
      print(listSchedule?.length);
      setState(() {
        checkData = true;
      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Schedule: ${e.toString()}')),
      );
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
                  print(appointmentDetails.subject);
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

