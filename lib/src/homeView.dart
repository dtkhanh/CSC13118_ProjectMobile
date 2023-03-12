import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/data.dart';


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
      appBar: AppBar(
        leading: Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.white,
        actions: const [
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue[700],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Upcoming Lesson',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '2023-03-11  20:00-00:00',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      const  Text(
                        ' ( Start in 65:43:51 ) ',
                        style: TextStyle(fontStyle: FontStyle.normal, fontSize: 13, color: Colors.yellow),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // set the radius here
                            ),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),),
                          onPressed: () { },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/join.svg",
                                semanticsLabel: 'Logo join',
                                width: 10,
                                height: 10,
                              ),
                              const SizedBox(width: 8.0),
                              const Text('Enter Lesson room ', style: TextStyle(fontSize: 15))],),
                          ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 24),
                    child: Text(
                      'Total Lesson Time: 4 hours 30 minutes',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child:  Row(
                children: const [
                  Text(
                    'Find a tutor',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  ),
                ],
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
                        ConstrainedBox(
                          constraints:const BoxConstraints(maxWidth: 250),
                          child:const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                hintText: "enter tutor name",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10), // Khoảng cách giữa TextField và DropdownButtonFormField
                        Expanded(
                          child:   DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              hintText: 'select nationality',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey, width: 2),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child:  Row(
                children: const [
                  Text(
                    'Select available tutoring time',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Column(
                  children:  [
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints:const BoxConstraints(maxWidth: 200),
                          child: Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                hintText: "select a day",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child:  Wrap(
                spacing: 8,
                runSpacing: -4,
                children: List<Widget>.generate(
                  filters.length,
                      (index) => ChoiceChip(
                    label: Text(
                      filters[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: chosenFilter == index ? Colors.blue[700] : Colors.black54,
                      ),
                    ),
                    backgroundColor: Colors.grey[200],
                    selectedColor: Colors.lightBlue[100],
                    selected: chosenFilter == index,
                    onSelected: (bool selected) {
                      setState(() {
                        chosenFilter = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
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
          ],
        ),
      ),
    );
  }
}