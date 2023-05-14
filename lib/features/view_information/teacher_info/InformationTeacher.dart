import 'package:csc13118_mobile/model/tutor/infoTutor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../../model/tutor/feedback.dart';
import '../../../services/tutorService.dart';
import '../../tutors/widget/viewRatting.dart';
import '../widget/cardReview.dart';
import '../widget/viewCalander.dart';
final iconProvider = StateProvider((ref) => Icons.favorite);

class InforTeacher extends StatefulWidget {
  final String userId;
  final List<FeedbacksTutor>? feedBacks;
  const InforTeacher({super.key, required this.userId, required this.feedBacks});
  @override
  State<InforTeacher> createState() => _InforTeacherState();
}

class _InforTeacherState extends State<InforTeacher> {
  late ChewieController _chewieController;
  late InfoTutor infoTutor;
  late String linkVideo ="";
  bool checkData = false;
  bool checkLoad = false;

  List<FeedbacksTutor>? listFeedBack;
  // late bool checkFavorite ;
  final ValueNotifier<bool> checkFavorite = ValueNotifier<bool>(true);


  @override
  void initState() {
    super.initState();
    listFeedBack = widget.feedBacks;
  }

  Future<void> _fetchTutorInfo( String id) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      infoTutor = await TuTorService.getIdTutor(token: check!, userId: id);
      linkVideo = infoTutor.video!;
      checkFavorite.value = infoTutor.isFavorite!;
      setState(() {
        checkData = true;
      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
  Future<void> _fetchAddFavoriteTutor(String id) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      await TuTorService.addFavoriteTutor(token: check!, tutorId: id);
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
  Future<void> _dialogBuilder() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.grey.shade200,
          title: const Text('Others review'),
          content:  SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: listFeedBack?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                return CardReview(feedBacksTutor: listFeedBack![index],);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    if(checkData == false){
      _fetchTutorInfo(widget.userId);
    }
    var specialties=[];
    var languages=[];

    if(checkData == true){
      specialties = infoTutor.specialties?.split(',').map((spec) => spec.replaceAll('-', ' ')).toList() ?? [];
      languages = infoTutor.languages?.split(',').map((spec) => spec.replaceAll('-', ' ')).toList() ?? [];
    }
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(linkVideo),
      autoPlay: false,
      looping: false,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            _chewieController.pause();
            Navigator.of(context).pop();
          },
          color: Colors.blue[600],
        ),
        title: Text(
          'Information Teacher',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            //letterSpacing: 1.0,
            color: Colors.blue[600],
          ),
        ),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: !checkData
            ?
        const Padding(
          padding: EdgeInsets.fromLTRB(2, 12, 2, 12),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        )
            :
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 12, 2, 12),
          child:  Column(
              children: [
                Column(
                  children: <Widget>[
                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(md:6 ,child: Padding(
                          padding:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    child: ClipOval(
                                        child: Image.network(
                                          infoTutor.user?.avatar ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text( infoTutor.user?.name ?? "", style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/svg/icon.svg",
                                              semanticsLabel:
                                              'Logo Icon',
                                              width: 20,
                                              height: 20,
                                            ),
                                            const SizedBox(
                                                width: 5),
                                            const Text("France", style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                        Ratting(rating: infoTutor.rating ?? 0,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                    infoTutor.bio ?? "",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14)),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child:ValueListenableBuilder<bool>(
                                    valueListenable: checkFavorite,
                                    builder: (BuildContext context, bool value, Widget? child) {
                                      return  TextButton(
                                        onPressed: () {
                                          _fetchAddFavoriteTutor(infoTutor.user!.id ?? "");
                                          checkFavorite.value = !checkFavorite.value;
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                                !checkFavorite.value? Icons.favorite_border  : Icons.favorite ,
                                                color: !checkFavorite.value? Colors.blue : Colors.red
                                            ),
                                            Text( 'Favorite',
                                              style: TextStyle(color: !checkFavorite.value? Colors.blue : Colors.red  ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    )
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        _dialogBuilder();
                                      },
                                      child: Column(
                                        children: const [
                                          Icon(Icons.reviews_outlined, color: Colors.blue),
                                          Text('Review', style: TextStyle(color: Colors.blue))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () async {
                                      },
                                      child: Column(
                                        children: const [
                                          Icon(Icons.report_outlined, color: Colors.blue),
                                          Text('Report', style: TextStyle(color: Colors.blue))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                        ),
                        ResponsiveGridCol(md:6 ,child:Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Set border radius
                          ),
                          surfaceTintColor: Colors.white,
                          elevation: 3.0,
                          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 250, // set the height of the container
                                child: Chewie(
                                  controller:  _chewieController
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),
                      ],
                    ),
                    ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(md:5 ,child: Padding(
                          padding:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Languages',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: List<Widget>.generate(
                                  languages.length,
                                      (index) => Positioned(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor :  Colors.lightBlue[100]  // set the background color of the button
                                      ),
                                      child: Text( languages[index], style: TextStyle( color: Colors.blue[700],
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding:const EdgeInsets.fromLTRB(0, 12, 0, 0),
                              //   child: ElevatedButton(
                              //     onPressed: () {
                              //     },
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor : Colors.lightBlue[100] , // set the background color of the button
                              //     ),
                              //     child: Text( 'English', style: TextStyle( color:Colors.blue[700] ,
                              //     ),),
                              //   ),
                              // ),
                              const SizedBox(height: 15,),
                              const Text('Specialties',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: -4,
                                children: List<Widget>.generate(
                                  specialties.length,
                                      (index) => Positioned(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor :  Colors.lightBlue[100]  // set the background color of the button
                                      ),
                                      child: Text( specialties[index], style: TextStyle( color: Colors.blue[700],
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              // const Text('Suggested Courses',  style: TextStyle(
                              //   fontSize: 16,
                              //   fontWeight: FontWeight.bold,
                              //   color: Colors.black,
                              // ),),
                              // Padding(
                              //   padding:const EdgeInsets.fromLTRB(5, 20, 0, 0),
                              //   child: Row(
                              //     children: const [
                              //       Text('Basic Conversation Topics:',  style: TextStyle(
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.black,
                              //       ),),
                              //       Text(' Link',  style: TextStyle(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.blue,
                              //       ),),
                              //
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(5, 20, 0, 0),
                                child: Row(
                                  children: const [
                                    Text('Life in the internet Age:',  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),),
                                    Text(' Link',  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),),

                                  ],
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('interests:',  style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(
                                      infoTutor.interests ?? "",
                                      style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),),)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15,),
                              const Text('Teaching experience',  style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(
                                      infoTutor.experience ?? "",
                                      style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),),)
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )
                        ),
                        ResponsiveGridCol(md:7 ,
                            child: !checkLoad ? ViewCalender(idTutors:  infoTutor.user!.id.toString() ?? "",) : const Text("")
                        ),
                      ],
                    )
                  ],
                )
              ]
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }
}
