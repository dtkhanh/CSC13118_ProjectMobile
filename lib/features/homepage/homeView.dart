import 'package:csc13118_mobile/features/homepage/widgets/cardTutor.dart';
import 'package:csc13118_mobile/features/homepage/widgets/viewJoin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/data.dart';
import '../../../constants/appSizes.dart';
import '../../routing/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewStage();


}

class _HomeViewStage extends State<HomeView> {
  int chosenFilter = 0;

  @override
  Widget build(BuildContext context) {
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
                children: [
                  const Expanded(
                    child: Text(
                      'Recommended Tutors',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.tutors,
                            (route) => false,
                      );
                    },
                    child: const Expanded(
                      child: Text(
                        'See all',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blueAccent),
                      ),
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                child:  Wrap(
                  spacing: 8,
                  runSpacing: -4,
                  children: List<Widget>.generate(
                      teachers.length,
                          (index) => CardTutor()
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