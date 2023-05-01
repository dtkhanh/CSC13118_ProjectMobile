import 'package:csc13118_mobile/features/tutors/widget/cardTutor.dart';
import 'package:csc13118_mobile/features/homepage/widgets/viewJoin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/appSizes.dart';
import '../../model/tutor/tutor.dart';
import '../../routing/routes.dart';
import '../../services/tutorService.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewStage();
}

class _HomeViewStage extends State<HomeView> {
  int chosenFilter = 0;
  bool checkData = false;
  List<Tutor> listTutor = [];
  List<dynamic>? responseTutor;

  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    getListTutor(check!);
  }


  void getListTutor(String tokenUser) async {
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
  Widget build(BuildContext context) {
    _initPrefs();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ViewJoin(),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            //   child: Text(
            //     'Select available tutoring time',
            //     textAlign: TextAlign.left,
            //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // ConstrainedBox(
            //   constraints: const BoxConstraints(maxWidth: 400),
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            //     child: Column(
            //       children:  [
            //         ConstrainedBox(
            //           constraints:const BoxConstraints(maxWidth: 200),
            //           child: Expanded(
            //             child: TextField(
            //               decoration: InputDecoration(
            //                 contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            //                 hintText: "select a day",
            //                 hintStyle: TextStyle(color: Colors.grey[400]),
            //                 border: const OutlineInputBorder(
            //                     borderSide: BorderSide(color: Colors.grey, width: 2),
            //                     borderRadius: BorderRadius.all(Radius.circular(20))),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            gapH4,
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),

              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Recommended Tutors',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.tutors,
                            (route) => false,
                      );
                    },
                      child: const Text(
                        'See all',
                        style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blueAccent),
                      ),
                  ),
                ],
              ),
            ),
            gapH4,
            Padding(
              padding: const  EdgeInsets.fromLTRB(12, 20, 12, 12),
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
            Center(
              child:  !checkData
                  ?
              const Text(
                'LOADING...',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
              )
                  :
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                child:  Wrap(
                  spacing: 8,
                  runSpacing: -4,
                  children: List<Widget>.generate(
                      listTutor.length,
                          (index) => CardTutor(tutor: listTutor[index],)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}