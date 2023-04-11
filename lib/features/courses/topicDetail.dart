import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:csc13118_mobile/page/navigationPage.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../../data/data.dart';

import '../../routing/routes.dart';

class TopicDetail extends StatefulWidget {
  const TopicDetail({Key? key}) : super(key: key);

  @override
  State<TopicDetail> createState() => _TopicDetailPage();
}

class _TopicDetailPage extends State<TopicDetail> {
  int chosenFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Topic Details',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            //letterSpacing: 1.0,
            color: Colors.blue[600],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child:  Column(
              children: [
                Column(
                  children: <Widget>[
                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(md:4 ,child: Padding(
                          padding:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: SizedBox(
                            height: 740,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child:    Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Set border radius
                                  ),
                                  surfaceTintColor: Colors.white,
                                  elevation: 3.0,
                                  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 300, // set the height of the container
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),// Set border radius
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/english-course.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Basic conversation Topics',
                                                style: TextStyle(
                                                    fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Padding( padding:const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: const Text(
                                                  'Gain confidence speaking about familiar topics',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14.0, color: Colors.grey, height: 1.6, fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                'List Topics',
                                                style: TextStyle(
                                                    fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold
                                                ),
                                              ),

                                              Column(
                                                children: List<Widget>.generate(
                                                  topic.length,
                                                      (index) => Positioned(
                                                    child: Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                      child:  SizedBox(
                                                        width: double.infinity,
                                                        height: 40,
                                                        child:   ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              chosenFilter = index;
                                                            });
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor : chosenFilter == index ?  Colors.lightBlue[100]   :  Colors.grey[200], // set the background color of the button
                                                          ),
                                                          child: Container(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text( topic[index], style: TextStyle( color: chosenFilter == index ? Colors.blue[700] : Colors.black54,
                                                            ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      )

                                    ],
                                  ),

                                ),
                            ),
                            ),
                          )
                        ),
                        ResponsiveGridCol(md:7 ,child:Padding(
                            padding:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child:SizedBox(
                              height: 740,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/english.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/english.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/english.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/english.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/english.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/english.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/english.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/english.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            )
                        )

                        ),
                      ],
                    )
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}