import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:intl/intl.dart';
import '../../../model/schedule/bookingInfo.dart';


class CardSchedule extends StatefulWidget {
  final BookingInfo booking;
  const CardSchedule({super.key, required this.booking});


  @override
  State<CardSchedule> createState() => _CardScheduleStage();

}

class _CardScheduleStage extends State<CardSchedule> {
  final _noteText = TextEditingController();

  Future<void> _dialogBuilder(String time , String Day) {
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
                const Text(
                  'Booking Day',
                  style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 ),
                ),
                const SizedBox(height: 8),
                Text(
                  Day,
                  style: const TextStyle(fontSize: 14),
                ),
                const Text(
                  'Booking time',
                  style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
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
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () async {
                },
                child: const Text('SUBMIT', style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold),)),
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
                        widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0)),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '1 lesson',
                          style: TextStyle(
                            fontSize: 10,
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
                                    widget.booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar  ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
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
                                  widget.booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name ?? " ",
                                  style: const TextStyle(
                                      fontSize: 18,
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
                                            14)),
                                  ],
                                ),
                                const SizedBox(
                                    height: 3),
                                const Text(
                                  'Direct Message',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                      color: Colors
                                          .blue),
                                ),
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
                              Row(
                                children: [
                                  Expanded(
                                    child:  Text(
                                      '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                          widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0))}-${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                          widget.booking.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: OutlinedButton.icon(
                                            onPressed: () => {
                                              _dialogBuilder("${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                            widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0))}-${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                          widget.booking.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}",DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                                                  widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0)) )
                                            },
                                            icon: const Icon(Icons.cancel , color: Colors.red,),
                                            label: const Text('Cancel' , style: TextStyle(color:  Colors.red,),),
                                          ),
                                        ) ,
                                      )

                                  ),
                                  const SizedBox(width: 10),
                                ],
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
                                            children: const [
                                              Icon( Icons.arrow_drop_down , color: Colors.black, size:25),

                                              Expanded(
                                                  child: Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                  child: Text(
                                                    'Request for lesson', style: TextStyle(color: Colors.black, fontSize: 14),
                                                  ),
                                                )
                                              ),
                                              Expanded(
                                                child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text('Edit Request' , style: TextStyle(color:  Colors.blue,)
                                                    )
                                                ),

                                              ),
                                              SizedBox(width: 10),
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
                                          child: Text( widget.booking.studentRequest ?? 'Current there are no requests for this class. Please write down any request for the teacher' , style: const TextStyle(color:  Colors.grey, fontSize: 14)),
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
                child: Text('Go to meeting', style: TextStyle( color: Colors.grey[500],
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

