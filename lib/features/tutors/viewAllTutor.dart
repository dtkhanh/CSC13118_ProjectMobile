import 'package:csc13118_mobile/features/homepage/widgets/cardTutor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/data.dart';
import '../../../constants/appSizes.dart';

class TuTorView extends StatefulWidget {
  const TuTorView({Key? key}) : super(key: key);

  @override
  State<TuTorView> createState() => _TuTorViewStage();


}

class _TuTorViewStage extends State<TuTorView> {
  int chosenFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Text(
                'Find a tutor',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: Sizes.p20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  children:  [
                    Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black12,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              hintText: "enter tutor name",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                        gapW8,
                        Expanded(
                          child:   DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              hintText: 'select nationality',
                              hintStyle: TextStyle(color: Colors.grey[400],  ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey,),
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                            onChanged: (value) {}, items: const [],
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
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor : chosenFilter == index ?  Colors.lightBlue[100]   :  Colors.grey[200], // set the background color of the button
                      ),
                      child: Text( filters[index], style: TextStyle( color: chosenFilter == index ? Colors.blue[700] : Colors.black54,
                      ),),
                    ),
                  ),
                ),
              ),
            ),
            gapH4,
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: ElevatedButton(
                onPressed: () {},
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
                child: const Text('Reset Filters', style: TextStyle(fontSize: 16)),
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
            gapH4,
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
            //     child:  Wrap(
            //       spacing: 8,
            //       runSpacing: -4,
            //       children: List<Widget>.generate(
            //           teachers.length,
            //               (index) => const CardTutor(listTutor: ,)
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}