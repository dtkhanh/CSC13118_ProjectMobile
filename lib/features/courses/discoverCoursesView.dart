import 'package:csc13118_mobile/features/courses/widget/CardCourse.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/data.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:csc13118_mobile/features/homepage/homeView.dart';
import 'package:csc13118_mobile/features/schedule/scheduleView.dart';
import 'package:csc13118_mobile/features/history/historyView.dart';
import '../../data/language.dart';
import '../../model/course/course.dart';
import '../../model/course/courseCategory.dart';
import '../../services/courseService.dart';

class DiscoverCourses extends StatefulWidget {
  const DiscoverCourses({Key? key}) : super(key: key);


  @override
  State<DiscoverCourses> createState() => _DiscoverCoursesViewStage();
}

class _DiscoverCoursesViewStage extends State<DiscoverCourses> {
  int chosenFilter = 0;
  String dropdownValue = 'One'; // Giá trị mặc định ban đầu
  List<Course> listCourse = [];
  bool checkData = false;
  late List<dynamic> categorys;
  late List<CourseCategory> listCategory =[];
  final search = TextEditingController();
  String idCategory ="";
  String q = "";
  String orderBy = "";
  static  int _totalPage = 0;
  int listLevel =100;
  List<String> levels = ['Any level', 'Beginner', 'Upper-Beginner', 'Pre-Intermediate','Upper-Intermediate','Pre-advanced','Advanced'];
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
    final totalElement = await await CourseService.getTotalElementCourse(api: "course",page: 1, perPage: 10,token: check!, q: "", categoryId: "",level: "",orderBy: "");
    categorys = await CourseService.getListCategory(token: check);
    for(int i=0;i<categorys.length;i++){
      listCategory.add(CourseCategory.fromJson(categorys[i]));
    }
    final language = prefs.getString('setLanguage')?? "en-US";
    setState(() {
      int result = totalElement.toInt() ~/ 10 + (totalElement.toInt() % 10 > 0 ? 1 : 0);
      _totalPage = result;
      language =="en-US" ? lag = Language(id: "en-US"): lag = Language(id: "vi-Vn");
    });
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      List<Course> newItems  = [];
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      String checkLevel = listLevel == 100 ? "" : listLevel.toString();
      String checkOrderBy = orderBy =="Level ascending" ? "ASC" : "DESC";
      if(chosenFilter == 0){
        newItems = await CourseService.getListCourse(api: "course",page: pageKey +1, perPage: 10,token: check!, q: q, categoryId: idCategory,level: checkLevel,orderBy: checkOrderBy);
        final totalElement = await CourseService.getTotalElementCourse(api: "course",page: pageKey +1, perPage: 10,token: check, q: q, categoryId: idCategory,level: checkLevel,orderBy: checkOrderBy);
        setState(() {
          int result = totalElement.toInt() ~/ 10 + (totalElement.toInt() % 10 > 0 ? 1 : 0);
          _totalPage = result;
        });
      }else if(chosenFilter ==1){
        newItems = await CourseService.getListCourse(api: "e-book",page: pageKey +1, perPage: 10,token: check!, q: q, categoryId: idCategory,level: checkLevel,orderBy: checkOrderBy);
        final totalElement = await CourseService.getTotalElementCourse(api: "e-book",page: pageKey +1, perPage: 10,token: check, q: q, categoryId: idCategory,level: checkLevel,orderBy: checkOrderBy);
        setState(() {
          int result = totalElement.toInt() ~/ 10 + (totalElement.toInt() % 10 > 0 ? 1 : 0);
          _totalPage = result;
        });
      }else if(chosenFilter ==2){
        newItems = await CourseService.getListCourse_Interactive_Ebook(token: check!);
      }
      final isLastPage = pageKey > _totalPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  List<Widget> pages = [
    const HomeView(),
    const ScheduleView(),
    const historyView(),
  ];

  final PagingController<int, Course> _pagingController =
  PagingController(firstPageKey: 0);

  void getListCourse() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      if(chosenFilter == 0){
        String checkLevel = listLevel == 100 ? "" : listLevel.toString();
        String checkOrderBy = orderBy =="Level ascending" ? "ASC" : "DESC";
        listCourse = await CourseService.getListCourse(api: "course",page: 1, perPage: 10,token: check!, q: q, categoryId: idCategory,level: checkLevel,orderBy: checkOrderBy);
      }else if(chosenFilter ==1){
        listCourse = await CourseService.getListCourseE_book(token: check!);
      }else if(chosenFilter ==2){
        listCourse = await CourseService.getListCourse_Interactive_Ebook(token: check!);
      }
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
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    getListCourse();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/images.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit
                              .cover,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lag.course,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: MediaQuery.of(context).size.width //
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 250,
                                height: 40,
                                child: TextField(
                                  controller: search,
                                  onChanged: (value) {
                                    value =="";
                                    setState(() {
                                      q=search.text;
                                      _pagingController.refresh();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(Radius.circular(5))),
                                    hintText: 'Course',
                                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 13,),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        setState(() {
                                          q=search.text;
                                          _pagingController.refresh();

                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                          lag.contentCourse1,
                          style: const TextStyle( fontSize: 14)
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        ResponsiveGridRow(
                          children: [
                            ResponsiveGridCol(md:4 ,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child:  SizedBox(
                                  height:40,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      isDense: true,
                                      alignLabelWithHint: true,
                                      hintText: lag.level,
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13, ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        listLevel = levels.indexOf(value!);
                                        _pagingController.refresh();
                                      });
                                    }, items: <String>['Any level', 'Beginner', 'Upper-Beginner', 'Pre-Intermediate','Upper-Intermediate','Pre-advanced','Advanced'].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child:Text(
                                        value,
                                        style: const TextStyle(color: Colors.black, fontSize: 13, ),
                                      ),

                                    );
                                  }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            ResponsiveGridCol(md:4 ,child:  Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child:  SizedBox(
                                height:40,
                                child:  DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(Radius.circular(5))),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    isDense: true,
                                    alignLabelWithHint: true,
                                    hintText: lag.category,
                                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 13,),

                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      idCategory = value?.id ?? "";
                                      _pagingController.refresh();
                                    });
                                  }, items:listCategory.map<DropdownMenuItem<CourseCategory>>((CourseCategory category) {
                                  return DropdownMenuItem<CourseCategory>(
                                    value: category,
                                    child: Text(
                                      category.title ?? "",
                                      style: const TextStyle(color: Colors.black, fontSize: 13, ),
                                    ),
                                  );
                                }).toList(),
                                ),
                              ),
                            ),),
                            ResponsiveGridCol(md:4 ,child:  Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child:  SizedBox(
                                height:40,
                                child:  DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(Radius.circular(5))),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    isDense: true,
                                    alignLabelWithHint: true,
                                    hintText: lag.sort,
                                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 13, ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      orderBy = value!;
                                      _pagingController.refresh();
                                    });
                                  }, items: <String>['Level ascending','Level decreasing'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(color: Colors.black, fontSize: 13, ),
                                    ),
                                  );
                                }).toList(),
                                ),

                              ),
                            ),),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 24, 12),
                      child:  Wrap(
                        spacing: 9,
                        runSpacing: 6,
                        children: List<Widget>.generate(
                          schedule.length,
                              (index) => InkWell(
                            onTap: () {
                              setState(() {
                                chosenFilter = index;
                                setState(() {
                                  checkData = false;
                                  _pagingController.refresh();
                                });
                                getListCourse();
                              });
                            },
                            child:  Text(
                              lag.id =="vi-Vn"? schedule_vn[index]  :
                              schedule[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: chosenFilter == index ? Colors.blue[700] : Colors.black,
                              ),
                            ),

                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const  EdgeInsets.fromLTRB(0, 20, 12, 12),
                      child: Container(
                        height: 1,
                        decoration:  BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 24, 24, 12),
                      child: chosenFilter ==0 ?  Row(
                        children: const [
                          Text(
                            'English For Traveling',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                          ),
                        ],
                      ) :  Row(
                        children: const [
                        ],
                      ),
                    ),

                    // !checkData
                    //     ?
                    // const Center(
                    //   child: Text(
                    //     'NO DATA',
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
                    //   ),
                    // )
                    //     :

                    // Center(
                    //   child:  chosenFilter == 0 ? Padding(
                    //     padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                    //     child:   PagedListView<int, Course>(
                    //       pagingController: _pagingController,
                    //       builderDelegate: PagedChildBuilderDelegate<Course>(
                    //           itemBuilder: (context, item, index) =>
                    //               Center(
                    //                   child: CardCourse(course: item,)
                    //               )
                    //       ),
                    //     ),
                    //   ) : chosenFilter == 1 ? Padding(
                    //     padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                    //     child:  Wrap(
                    //       spacing: 8,
                    //       runSpacing: -4,
                    //       children: List<Widget>.generate(
                    //           listCourse.length,
                    //               (index) => CardCourse(course: listCourse[index],)
                    //       ),
                    //     ),
                    //   ) : Padding(
                    //     padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                    //     child:  Wrap(
                    //       spacing: 8,
                    //       runSpacing: -4,
                    //       children: List<Widget>.generate(
                    //           listCourse.length,
                    //               (index) => CardCourse(course: listCourse[index],)
                    //       ),
                    //     ),
                    //   )
                    // ),
                  ],
                ),
              ),
            ),

          ),
          SliverFillRemaining(
            child: PagedListView<int, Course>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Course>(
                  itemBuilder: (context, item, index) =>
                      Center(
                          child: CardCourse(course: item,)
                      )
              ),
            ),
          ),
        ],
      )

    );
  }
}
