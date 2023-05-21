import 'package:csc13118_mobile/features/schedule/widget/cardSchedule.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/language.dart';
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
  static  int _totalPage = 0;
  List<List<BookingInfo>> groupedItems = [];
  Language lag = Language(id: "en-US");


  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _initPrefs();
    super.initState();
  }

  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    final totalElement = await ScheduleService.getToTalElementSchedule(token: check!, page: 1, perPage: 20);
    final language = prefs.getString('setLanguage')?? "en-US";
    setState(() {
      int result = totalElement.toInt() ~/ 20 + (totalElement.toInt() % 20 > 0 ? 1 : 0);
      _totalPage = result;
      language =="en-US" ? lag = Language(id: "en-US"): lag = Language(id: "vi-Vn");

    });
  }
  final PagingController<int, List<BookingInfo> > _pagingController =
  PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      final newItems = await ScheduleService.getListClassBooking(page: pageKey +1,perPage: 20,token: check!);
      List<BookingInfo> currentGroup = [];
      List<List<BookingInfo>> groupedItemsNew = [];
      for (int i = 0; i < newItems.length ; i++) {
        BookingInfo currentItem = newItems[i];
        DateTime currentStartTime = DateTime.fromMillisecondsSinceEpoch(
            currentItem.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
        String currentDateTime = DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
            currentItem.scheduleDetailInfo!.startPeriodTimestamp ?? 0));
        if (currentGroup.isEmpty || currentStartTime.difference(DateTime.fromMillisecondsSinceEpoch(
            currentGroup.last.scheduleDetailInfo?.endPeriodTimestamp ?? 0)).inMinutes <= 5
            && currentDateTime == DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                currentGroup.last.scheduleDetailInfo!.startPeriodTimestamp ?? 0))) {
          currentGroup.add(newItems[i]);
        } else {
          groupedItemsNew.add(currentGroup);
          currentGroup = [newItems[i]];
          if(i == newItems.length -1){
            groupedItemsNew.add([newItems[i]]);
          }
        }
      }
      final totalElement = await ScheduleService.getToTalElementSchedule(page: pageKey +1,perPage: 20,token: check);
      setState(() {
        int result = totalElement.toInt() ~/ 20 + (totalElement.toInt() % 20 > 0 ? 1 : 0);
        _totalPage = result;
      });
      final isLastPage = pageKey > _totalPage;
      if (isLastPage) {
        _pagingController.appendLastPage(groupedItemsNew);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(groupedItemsNew, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void GoupItemSchedule(List<BookingInfo> listBookClass){
    List<BookingInfo> currentGroup = [];
    List<List<BookingInfo>> groupedItemsNew = [];
    for (int i = 0; i < listBookClass.length ; i++) {
      BookingInfo currentItem = listBookClass[i];
      DateTime currentStartTime = DateTime.fromMillisecondsSinceEpoch(
          currentItem.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
      String currentDateTime = DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
          currentItem.scheduleDetailInfo!.startPeriodTimestamp ?? 0));
      if (currentGroup.isEmpty || currentStartTime.difference(DateTime.fromMillisecondsSinceEpoch(
          currentGroup.last.scheduleDetailInfo?.endPeriodTimestamp ?? 0)).inMinutes <= 5
          && currentDateTime == DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
              currentGroup.last.scheduleDetailInfo!.startPeriodTimestamp ?? 0)) && currentItem.userId ==currentGroup.last.userId) {
        currentGroup.add(listBookClass[i]);
      } else {
        groupedItemsNew.add(currentGroup);
        currentGroup = [listBookClass[i]];
        if(i == listBookClass.length -1){
          groupedItemsNew.add([listBookClass[i]]);
        }
      }
    }
    setState(() {
      groupedItems=groupedItemsNew;
    });
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void getListBooking() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      listBookClass = await ScheduleService.getListClassBooking(token: check!, page: 1, perPage: 20);
      GoupItemSchedule(listBookClass);
      setState(() {
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
    _pagingController.refresh();

    GoupItemSchedule(listBookClass);
    _fetchPage(0);
    _pagingController.refresh();
    setState(() {
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
      body: Column(
        children: [
          SingleChildScrollView(
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
                            Text(
                              lag.schedule,
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
                                    lag.content1,
                                    style: const TextStyle(fontSize: 13, height: 1.3)),
                                Text(
                                    lag.content2,
                                    style: const TextStyle(fontSize: 13, height: 1.3)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

              ),
            ),
          ),

          Expanded(
            child:PagedListView<int, List<BookingInfo>>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<List<BookingInfo>>(
                  itemBuilder: (context, item, index) =>
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child:  SizedBox(
                        child: CardSchedule(bookings: item, onPressed: renderCall)),
                  )
              ),
            ),
          ),
        ],
      )

    );
  }
}
