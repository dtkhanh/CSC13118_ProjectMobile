import 'package:csc13118_mobile/features/tutors/widget/viewRatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/appSizes.dart';
import '../../../data/language.dart';
import '../../../model/tutor/infoTutor.dart';
import '../../../model/tutor/tutor.dart';
import '../../../providers/activateTheme.dart';
import '../../../services/tutorService.dart';
import '../../view_information/teacher_info/InformationTeacher.dart';
import 'package:http/http.dart' as http;


class CardTutor extends StatefulWidget {
  final Tutor tutor;
  const CardTutor({super.key, required this.tutor});
  @override
  State<CardTutor> createState() => _CardTutorStage();

}

class _CardTutorStage extends State<CardTutor> {
  int chosenFilter = 0;
  final ValueNotifier<bool> checkFavorite = ValueNotifier<bool>(true);
  late InfoTutor infoTutor;
  Language lag = Language(id: "vi-Vn");

  @override
  void initState() {
    super.initState();
    checkFavoriteTutor();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('setLanguage')?? "en-US";
    setState(() {
      language =="en-US" ? lag = Language(id: "en-US"): lag = Language(id: "vi-Vn");
    });
  }


  Future<void> checkFavoriteTutor() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    infoTutor = await TuTorService.getIdTutor(token: check!, userId: widget.tutor.userId ?? "");
    checkFavorite.value = infoTutor.isFavorite!;
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


  bool _checkImageExists(String uri) {
    bool check = false;
    http.head(Uri.parse(uri)).then((response) {
      if(response.statusCode == 200) {
        check = true;
        return true;
      }
    }).catchError((error) {
     return false;
    });
    return check;
  }
  @override
  Widget build(BuildContext context) {
    final specialties = widget.tutor.specialties?.split(',').map((spec) => spec.replaceAll('-', ' ')).toList() ?? [];
    return SizedBox(
        width: 420,
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 3.0,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InforTeacher(userId: widget.tutor.userId ?? '',feedBacks: widget.tutor.feedbacks ?? [],)),
                        );
                      },
                      child: CircleAvatar(
                        radius: 45,
                        child: ClipOval(
                          child: Image.network(
                            widget.tutor.avatar ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        ),
                      )
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Text(
                                widget.tutor.name ?? '',
                                style: const TextStyle(
                                  fontSize: Sizes.p20,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/icon.svg",
                                  semanticsLabel: 'Logo Icon',
                                  width: 25,
                                  height: 25,
                                ),
                                gapW4,
                                const Text("France", style: TextStyle(fontSize: Sizes.p16)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Ratting(rating: widget.tutor.rating ?? 0,),
                          ],
                        ),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: checkFavorite,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return  IconButton(
                          onPressed: () {
                            _fetchAddFavoriteTutor(widget.tutor.userId ?? "");
                            checkFavorite.value = !checkFavorite.value;
                          },
                          icon:  Icon(
                              !checkFavorite.value? Icons.favorite_border  : Icons.favorite ,
                              color: !checkFavorite.value? Colors.blue : Colors.red
                          ),
                        );
                      },
                    ),
                  ],
                ),
                gapH12,
                Wrap(
                  spacing: 5,
                  runSpacing: -4,
                  children: List<Widget>.generate(
                    specialties.length,
                        (index) =>
                            Chip(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                              backgroundColor: Colors.lightBlue[100],
                              label: Text( specialties[index], style: TextStyle( color:  Colors.blue[700], fontSize: Sizes.p12),
                              ),
                            ),
                  ),
                ),
                gapH12,
                 Text(
                  widget.tutor.bio ?? '',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: Sizes.p12, color: Colors.grey, height: 1.6
                  ),
                ),
                gapH12,
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InforTeacher(userId: widget.tutor.userId ?? '',feedBacks: widget.tutor.feedbacks ?? [],)),
                      );
                    },
                    icon: const Icon(Icons.edit_calendar),
                    label: Text(lag.book),
                    // label: Text(lag.book , style: TextStyle(color: Theme.of(context).colorScheme)),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

