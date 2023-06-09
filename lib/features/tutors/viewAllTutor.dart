import 'package:csc13118_mobile/features/tutors/widget/cardTutor.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/data.dart';
import '../../../constants/appSizes.dart';
import '../../data/language.dart';
import '../../model/tutor/tutor.dart';
import '../../services/tutorService.dart';

class TuTorView extends StatefulWidget {
  const TuTorView({Key? key}) : super(key: key);

  @override
  State<TuTorView> createState() => _TuTorViewStage();


}

class _TuTorViewStage extends State<TuTorView> {
  int chosenFilter = 0;
  List<Tutor> listTutor = [];
  bool checkData = false;
  String nationality ="";
  static  int _totalPage = 0;
  static String specialties = "";
  static List<String> filter = [];
  final _searchName = TextEditingController();

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
    final totalElement = await TuTorService.getToTalElement(page: 1,perPage: 9,token: check!);
    final language = prefs.getString('setLanguage')?? "en-US";
    setState(() {
      int result = totalElement.toInt() ~/ 9 + (totalElement.toInt() % 9 > 0 ? 1 : 0);
      _totalPage = result;
      language =="en-US" ? lag = Language(id: "en-US"): lag = Language(id: "vi-Vn");
    });
  }

  final PagingController<int, Tutor> _pagingController =
  PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      filter = [];
      if(specialties.length != 0 && specialties != "all"){
        filter.add(specialties);
      }
      if(_searchName.text.length !=0){

      }
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      final newItems = await TuTorService.getListTutorWithSearch(page: pageKey +1,perPage: 9,token: check!, specialties: filter,search: _searchName.text);
      final totalElement = await TuTorService.getToTalElement(page: pageKey +1,perPage: 9,token: check, specialties: filter, search: _searchName.text);
      setState(() {
        int result = totalElement.toInt() ~/ 9 + (totalElement.toInt() % 9 > 0 ? 1 : 0);
        _totalPage = result;
      });
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
  void getListTutorWithPagination(String tokenUser, int Page) async {
    try{
      listTutor = await TuTorService.getTutors(page: 1,perPage: 9,token: tokenUser);
      if (mounted) {
        setState(() {
          checkData = true;
        });
      }
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login: ${e.toString()}')),
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
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Padding(
                //   padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                //   child: Text(
                //     'Find a tutor',
                //     textAlign: TextAlign.left,
                //     style: TextStyle(fontSize: Sizes.p20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                //   ),
                // ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Column(
                      children:  [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchName,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.black12,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                  hintText: lag.enterTutorName,
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                ),
                                onSubmitted: (value) {
                                  _pagingController.refresh();
                                },
                              ),
                            ),
                            gapW8,
                            Expanded(
                              child:   DropdownButtonFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                  hintText: nationality == "" ? lag.selectNatio : nationality,
                                  hintStyle: TextStyle(color: Colors.grey[400],  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey,),
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    nationality = value!;
                                  });
                                }, items: <String>['Foreign Tutor', 'Vietnamese Tutor', 'Native English Tutor'].map<DropdownMenuItem<String>>((String value) {
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
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                gapH4,
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child:  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  Wrap(
                      spacing: 8,
                      runSpacing: 3,
                      children: List<Widget>.generate(
                        filters.length,
                            (index) => Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                chosenFilter = index;
                                specialties = filters[index].toLowerCase().replaceAll(' ', '-');
                              });
                              _pagingController.refresh();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor : chosenFilter == index ?  Colors.lightBlue[100]   :  Colors.grey[200], // set the background color of the button
                            ),
                            child: Text( lag.id =="vi-Vn" ?filters_VN[index] : filters[index], style: TextStyle( color: chosenFilter == index ? Colors.blue[700] : Colors.black54,
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                gapH4,
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        chosenFilter = 0;
                        specialties = filters[0].toLowerCase().replaceAll(' ', '-');
                        _searchName.clear();
                        nationality ="";
                      });
                      _pagingController.refresh();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.red;
                          }
                          return Colors.blue;
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: Text(lag.ResetFilters, style: TextStyle(fontSize: 16,  color: Colors.grey.shade800,)),
                  ),
                ),
                gapH4,
                Padding(
                  padding: const  EdgeInsets.fromLTRB(12, 2, 12, 0),
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
              ],
            ),
          ),
          Expanded(
            child:PagedListView<int, Tutor>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Tutor>(
                itemBuilder: (context, item, index) =>
                Center(
                  child: CardTutor(tutor: item,)
                )
              ),
            ),
          ),
        ],
      ),

    );
  }
}