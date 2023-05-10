import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:intl/intl.dart';
import '../../../model/schedule/bookingInfo.dart';


class CardHistory extends StatefulWidget {
  final BookingInfo booking;
  const CardHistory({super.key, required this.booking});


  @override
  State<CardHistory> createState() => _CardHistoryStage();

}

class _CardHistoryStage extends State<CardHistory> {
  int rate = 5;

  Future<void> _dialogAddRating() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.grey.shade200,
          title: const Center(
            child: Text('Add a rating' ,  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          ),
          content:  Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
                const SizedBox(height: 4,),
                Text(
                  widget.booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name ??
                      '',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight
                          .bold),
                ),
                const SizedBox(height: 12,),
                const Text(
                  'Lesson Time',
                  style: TextStyle(
                      fontSize: 14,
                    ),
                ),
                const SizedBox(height: 4,),
                Text(
                  DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                      widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0)) + " "+  '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0))}-${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      widget.booking.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'What is your rating for ',
                  style:  TextStyle(
                      fontSize: 12,
                     ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(
                      5,
                          (index) => InkWell(
                        onTap: () {
                          setState(() {
                            rate = index + 1;
                          });
                        },
                        child: Icon(
                          Icons.star,
                          color: index < rate ? Colors.amber : Colors.grey,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      hintText: 'Content Review',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'later',
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () async {
                },
                child: const Text('send', style: TextStyle(color: Colors.blue , fontSize: 16, fontWeight: FontWeight.bold),)),
          ],
        );
      },
    );
  }
  Future<void> _dialogReport() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.grey.shade200,
          title: const Center(
            child: Text('Add a rating' ,  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          ),
          content:  Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
                const SizedBox(height: 4,),
                Text(
                  widget.booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name ??
                      '',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight
                          .bold),
                ),
                const SizedBox(height: 12,),
                const Text(
                  'Lesson Time',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4,),
                Text(
                  DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                      widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0)) + " "+  '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0))}-${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      widget.booking.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Expanded(child: Text(
                  'What was the reason you reported on the lesson? ',
                  style:  TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold
                  ),
                ),),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      hintText: 'Additional Notes',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'later',
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () async {
                },
                child: const Text('Submit', style: TextStyle(color: Colors.blue , fontSize: 16, fontWeight: FontWeight.bold),)),
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
                    padding: const EdgeInsets.fromLTRB(24, 5, 24, 5),
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
                          '6 hours ago ',
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => InforTeacher()),
                            // );
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
                                  widget.booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name ??
                                      '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight
                                          .bold),
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
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                        child: Column(
                          children: [
                            Container(
                              alignment: const Alignment(0, 0),
                              color: Colors.grey[100],
                              child:  Padding(
                                padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                child:
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Lession Time: ' '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                        widget.booking.scheduleDetailInfo!.startPeriodTimestamp ?? 0))}-${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                                        widget.booking.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}'
                                      ,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              alignment: const Alignment(0, 0),
                              color: Colors.grey[100],
                              child:  Padding(
                                padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                child:
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'No request for lesion',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2,),
                            Container(
                              alignment: const Alignment(0, 0),
                              color: Colors.grey[100],
                              child:  Padding(
                                padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                child:
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'Tutor have not reviewed yet',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2,),
                            Container(
                              alignment: const Alignment(0, 0),
                              color: Colors.grey[100],
                              child:  Padding(
                                padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                                child:
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child:  InkWell(
                                                onTap: () {
                                                  _dialogAddRating();
                                                },
                                                child: const Text(
                                                  'Add a rating',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              )
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topRight,
                                              child:  InkWell(
                                                onTap: () {
                                                  _dialogReport();
                                                },
                                                child: const Text(
                                                  'Report',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        )

                    )
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Positioned(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // set the background color of the button
                        ),
                        child: const Text('Go to meeting', style: TextStyle( color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

