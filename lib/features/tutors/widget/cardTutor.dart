import 'package:csc13118_mobile/features/tutors/widget/viewRatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/appSizes.dart';
import '../../../model/tutor/tutor.dart';
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
                    IconButton(
                      onPressed: () {
                        // Xử lý khi người dùng bấm vào nút IconButton
                      },
                      icon: const Icon( Icons.favorite , color: Colors.blue, size:25),
                    )
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
                    onPressed: () => {},
                    icon: const Icon(Icons.edit_calendar),
                    label: const Text('Book'),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
