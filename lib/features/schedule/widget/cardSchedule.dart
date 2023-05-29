import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/appSizes.dart';
import '../../../data/language.dart';
import '../../../model/schedule/bookingInfo.dart';
import '../../../services/scheduleService.dart';


class CardSchedule extends StatefulWidget {
  final List<BookingInfo> bookings;
  final VoidCallback onPressed;
  const CardSchedule({super.key, required this.bookings, required this.onPressed});


  @override
  State<CardSchedule> createState() => _CardScheduleStage();

}

class _CardScheduleStage extends State<CardSchedule> {
  late final _noteText = TextEditingController();
  String reasonCancel = "";
  String checkTheme ="";
  Language lag = Language(id: "en-US");
  bool checkBook =true;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }
  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final _theme = prefs.getString('theme');
    final language = prefs.getString('setLanguage')?? "en-US";
    setState(() {
      language =="en-US" ? lag = Language(id: "en-US"): lag = Language(id: "vi-Vn");
      checkTheme = _theme!;
    });
  }

  bool checkBooking(BookingInfo book){
    int? milliseconds = book.scheduleDetailInfo!.startPeriodTimestamp; // Giá trị thời gian trong milliseconds
    DateTime currentTime = DateTime.now(); // Giờ hiện tại
    Duration diff = currentTime.difference(DateTime.fromMillisecondsSinceEpoch(milliseconds!));
    bool isTimeDifferenceAtLeast2Hours = diff.inHours.abs() < 2;
    return isTimeDifferenceAtLeast2Hours;
  }

  void cancelBooking( String scheduleDetail) async {
    try{
      int value =0;
      if(reasonCancel == 'Reschedule at another time'){
        value =1;
      } else if(reasonCancel == 'Busy at that time'){
        value =2;
      } else if(reasonCancel == 'Asked by the tutor'){
        value =3;
      } else{
        value =4;
      }
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      await ScheduleService.cancelBookedClass(token: check!, cancelReasonId: value , note: _noteText.text, scheduleDetailIds: scheduleDetail );
      setState(() {

      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : ${e.toString()}')),
      );
    }
  }


  Future<void> _dialogBuilder(String time , String Day, String id,  VoidCallback onButtonPressed) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.grey.shade200,
          title: const Center(
            child: Text('Cancel booking' ,  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          ),
          content: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 70,
                    height: 70,
                    child:  CircleAvatar(
                      radius: 45,
                      child: ClipOval(
                          child: Image.network(
                            widget.bookings[0].scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar  ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                      ),
                    )
                ),
                Text(
                  widget.bookings[0].scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name ?? " ",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15,),
                const Text(
                  'Lesson Time',
                  style: TextStyle(fontSize: 16 ),
                ),
                const SizedBox(height: 8),
                Text(
                  Day,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5,),
                Text(
                  time,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  "What was the reason you cancel this booking?",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
                gapH8,
                Expanded(
                  child:  DropdownButtonFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      hintText: reasonCancel.isNotEmpty ? reasonCancel : '',
                      hintStyle: const TextStyle(fontWeight: FontWeight.w300, color: Colors.grey, fontSize: 15),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    onChanged: (value) {
                      setState(() {
                        reasonCancel = value!;
                      });
                    }, items: <String>['Reschedule at another time',
                    'Busy at that time',
                    'Asked by the tutor',
                    'Other',].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    );
                  }).toList(),
                  ),
                ),
                Expanded(child: TextField(
                  controller: _noteText,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Additional Notes',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey, fontSize: 15),
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {
                    reasonCancel = "";
                    _noteText.text = "";
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Later',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
            reasonCancel.isEmpty ?
            TextButton(
                onPressed: () async {
                  cancelBooking(id);
                  onButtonPressed();
                  reasonCancel = "";
                  _noteText.text = "";
                  Navigator.pop(context);
                },
                child: const Text('Submit', style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold),))
                :
            TextButton(
                onPressed: () async {
                  reasonCancel = "";
                  _noteText.text = "";
                  widget.onPressed;
                },
                child: const Text('Submit', style: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold),)),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      surfaceTintColor: Colors.white,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  md: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                        widget.bookings[0].scheduleDetailInfo!.startPeriodTimestamp ?? 0)),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.bookings.length > 1
                            ?
                          '${widget.bookings.length} ${lag.consecutiveLessons}'
                              :
                          '${widget.bookings.length} ${lag.lessons}',
                          style: const TextStyle(
                            fontSize: 10,color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  md: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                          },
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child:  CircleAvatar(
                              radius: 45,
                              child: ClipOval(
                                  child: Image.network(
                                    widget.bookings[0].scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar  ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                              ),
                            )
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets
                                .symmetric(
                                horizontal: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  widget.bookings[0].scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name ?? " ",
                                  style: const TextStyle(
                                      fontSize: 18,color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                    height: 3),
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
                                    const Text("France",
                                        style: TextStyle(
                                            fontSize:
                                            14,color: Colors.black,)),
                                  ],
                                ),
                                const SizedBox(
                                    height: 3),
                                Row(
                                  children: [
                                    const Icon( Icons.chat, color: Colors.blue, size:20 ),
                                    const SizedBox(width: 5,),
                                    Text(
                                      lag.DirectMess,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color: Colors
                                              .blue),
                                    ),
                                  ],
                                )

                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                ResponsiveGridCol(
                    md: 6,
                    child:  Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Container(
                        alignment: const Alignment(0, 0),
                        color: Colors.grey[100],
                        child:  Padding(
                          padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                          child: Column(
                            children: [
                              Wrap(
                                  spacing: 6,
                                  runSpacing: 8,
                                  children: List<Widget>.generate(
                                      widget.bookings.length,
                                          (index) =>  SizedBox(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child:  Text(
                                                  '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                                      widget.bookings[index].scheduleDetailInfo!.startPeriodTimestamp ?? 0))}-${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                                      widget.bookings[index].scheduleDetailInfo!.endPeriodTimestamp ?? 0))}',
                                                  style: const TextStyle(
                                                      fontSize: 16,color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                    child: Align(
                                                      alignment: Alignment.topRight,
                                                      child: checkBooking(widget.bookings[index]) == true
                                                      ?
                                                      const Text("")
                                                      :
                                                      OutlinedButton.icon(
                                                        style: ButtonStyle(
                                                          side: MaterialStateProperty.all(const BorderSide(
                                                            color: Colors.red,
                                                            width: 2,
                                                          )),
                                                        ),
                                                        onPressed: () => {
                                                          _dialogBuilder("${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                                              widget.bookings[index].scheduleDetailInfo!.startPeriodTimestamp ?? 0))}-${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                                              widget.bookings[index].scheduleDetailInfo!.endPeriodTimestamp ?? 0))}",DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                                                              widget.bookings[index].scheduleDetailInfo!.startPeriodTimestamp ?? 0)) ,widget.bookings[index].id ?? "" , widget.onPressed)
                                                        },
                                                        icon: const Icon(Icons.cancel , color: Colors.red,),
                                                        label: Text(lag.cancel , style: const TextStyle(color:  Colors.red,),),
                                                      ),
                                                    ) ,
                                                  )

                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                      )
                                  )
                              ),

                              const SizedBox( height: 10),
                              Table(
                                border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                          child: Row(
                                            children: [
                                              const Icon( Icons.arrow_drop_down , color: Colors.black, size:25),
                                              Expanded(
                                                  child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                  child: Text(
                                                    lag.RequestForLesson, style: const TextStyle(color: Colors.black, fontSize: 14),
                                                  ),
                                                )
                                              ),
                                              Expanded(
                                                child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text(lag.EditRequest , style: const TextStyle(color:  Colors.blue,)
                                                    )
                                                ),

                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
                                          child: Text( widget.bookings[0].studentRequest ?? lag.contentCardSchedule , style: const TextStyle(color:  Colors.grey, fontSize: 14)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                ),
              ],
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100], // set the background color of the button
                ),
                child: Text(lag.goToMeet, style: TextStyle( color: Colors.grey[500],
                ),),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

