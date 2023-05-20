
import 'package:csc13118_mobile/model/course/course.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TopicDetail extends StatefulWidget {
  final Course courseDetail;
  final int topic;
  const TopicDetail({super.key, required this.courseDetail, required this.topic});


  @override
  State<TopicDetail> createState() => _TopicDetailPage();
}

class _TopicDetailPage extends State<TopicDetail> {
  int chosenFilter = 0;
  String url = "";
  bool checkLoad = false;
  UniqueKey _pdfViewerKey = UniqueKey();



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
          padding: const EdgeInsets.fromLTRB(6, 12, 6, 12),
          child:  Column(
              children: [
                Padding(
                  padding:const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Expanded(
                    child:  Card(
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
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),// Set border radius
                              image: DecorationImage(
                                image: NetworkImage( widget.courseDetail.imageUrl ??'assets/images/english.png'),
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
                                  Text(
                                    widget.courseDetail.name ?? "",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding( padding:const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Text(
                                      widget.courseDetail.description ?? "",                                                  maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
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
                                      widget.courseDetail.topics?.length ?? 0,
                                          (index) => Positioned(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child:  SizedBox(
                                            width: double.infinity,
                                            height: 40,
                                            child:   ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  chosenFilter = index;
                                                  _pdfViewerKey = UniqueKey();
                                                  url = widget.courseDetail.topics![index].nameFile ?? "";
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor :widget.topic != 0 &&  chosenFilter ==0 ? widget.topic == index ?  Colors.lightBlue[100]   :  Colors.grey[200] :chosenFilter == index ?  Colors.lightBlue[100]   :  Colors.grey[200], // set the background color of the button
                                              ),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(  widget.courseDetail.topics![index].name ?? ""
                                                  , style: TextStyle( color:widget.topic != 0 &&  chosenFilter ==0 ? widget.topic == index ? Colors.blue[700] : Colors.black54 : chosenFilter == index ? Colors.blue[700] : Colors.black54,
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
                Padding(
                  padding:const EdgeInsets.fromLTRB(5, 10, 5, 20),
                  child: SafeArea(
                      child: SizedBox(
                        height: 500,
                        child:  SfPdfViewer.network(
                          url =="" ? widget.courseDetail.topics![widget.topic].nameFile ?? "" :url,key: _pdfViewerKey,),
                      )
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}