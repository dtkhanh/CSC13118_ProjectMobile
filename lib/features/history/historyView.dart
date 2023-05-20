import 'package:csc13118_mobile/features/history/widget/cardHistory.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/language.dart';
import '../../model/schedule/bookingInfo.dart';
import '../../services/scheduleService.dart';

class historyView extends StatefulWidget {
  const historyView({Key? key}) : super(key: key);


  @override
  State<historyView> createState() => _HistoryViewStage();
}

class _HistoryViewStage extends State<historyView> {
  int chosenFilter = 0;
  List<BookingInfo> listBookClass = [];
  bool checkData = false;
  Language lag = Language(id: "vi-Vn");

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }
  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('setLanguage')?? "en-US";
    setState(() {
      language =="en-US" ? lag = Language(id: "en-US"): lag = Language(id: "vi-Vn");
    });
  }


  void getListHistory() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      listBookClass = await ScheduleService.getListClassBooking(token: check!, page: 1, perPage: 100);
      setState(() {
        checkData = true;
      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : ${e.toString()}')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    getListHistory();
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
                    'assets/images/callHistory.png',
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
                        Text(
                          lag.history,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: MediaQuery.of(context).size.width //
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                lag.contentHistory1,
                                style: const TextStyle(fontSize: 13, height: 1.3)),
                            Text(
                                lag.contentHistory2,
                                style: const TextStyle(fontSize: 13, height: 1.3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                child:   !checkData
                    ?
                Center(
                  child: Text(
                    lag.loading,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
                  ),
                )
                    :

                Wrap(
                    spacing: 6,
                    runSpacing: 8,
                    children: List<Widget>.generate(
                        listBookClass.length,
                            (index) =>  SizedBox(
                            child: CardHistory(booking:listBookClass[index] ,)
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
