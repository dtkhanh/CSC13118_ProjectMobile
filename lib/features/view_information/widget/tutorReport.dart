import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/tutor/feedback.dart';
import '../../../services/tutorService.dart';
import '../../tutors/widget/viewRatting.dart';

class TutorReport extends StatefulWidget {
  final String tutorId;
  final String Name;
  const TutorReport({super.key, required this.Name, required this.tutorId});
  @override
  State<TutorReport> createState() => _TutorReportDialogStage();

}

class _TutorReportDialogStage extends State<TutorReport> {
  final List<String> _contents = [
    'This tutor is annoying me\n',
    'This profile is pretending be someone or is fake\n',
    'Inappropriate profile photo\n',
  ];
  final _content = TextEditingController();
  final List<bool> _choices = [false, false, false];




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.white,
      title: Text('Report ${widget.Name}', style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),),
      content:   Padding(
        padding: const EdgeInsets.all(13),
        child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              const SizedBox(height: 15,),
              Row(
                children: const [
                  Icon(Icons.error, color: Colors.blue, size: 20,),
                  SizedBox(width: 3,),
                  Text(
                    "Help us understand what's happening",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6,),
              ...List<Widget>.generate(_choices.length, (index) {
                return Row(
                  children: <Widget>[
                    Checkbox(
                      value: _choices[index],
                      onChanged: (value) {
                        setState(() {
                          _choices[index] = value!;
                        });
                      },
                    ),
                    Expanded(child: Text(_contents[index],  style:  TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700
                    ),)),
                  ],
                );
              }),
              Expanded(
                child: TextField(
                  controller: _content,
                  minLines: 4,
                  maxLines: 5,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    hintText: 'Please let us know details about your problems',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey, fontSize: 15),
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ),
            ]
        ),
      ),

      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel', style: TextStyle(fontSize: 18),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        _choices.contains(true) || _content.text.isNotEmpty ?
        TextButton(
          onPressed: () async {
            String content = '';
            for (int i = 0; i < _choices.length; ++i) {
              if (_choices[i]) {
                  content = content + _contents[i] +r'\n';
              };
            }
            try{
              final prefs = await SharedPreferences.getInstance();
              String? check =  prefs.getString('accessToken');
              await TuTorService.reportTutor(token: check!, tutorId: widget.tutorId, content: content);
              if (mounted) {
                Navigator.pop(context, true);
              }

            }catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${e.toString()}')),
              );
            }
          },
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 18),
          ),
        )

            :
        TextButton(
          onPressed: () {

          },
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
      ],
    );

    //   AlertDialog(
    //   contentPadding: const EdgeInsets.all(0),
    //   backgroundColor: Colors.grey.shade200,
    //   title: const Text('Report name', style: TextStyle(
    //     fontSize: 24,
    //     fontWeight: FontWeight.bold,
    //   ),),
    //   content:  SizedBox(
    //     width: double.maxFinite,
    //     child:  const Text(
    //       "Help us understand what's happening",
    //       style: TextStyle(
    //         fontSize: 17,
    //         fontWeight: FontWeight.w600,
    //       ),
    //     ),
    //     // child: Column(
    //     //   mainAxisSize: MainAxisSize.min,
    //     //   children: [
    //         const Text(
    //           "Help us understand what's happening",
    //           style: TextStyle(
    //             fontSize: 17,
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //     //     ListView.builder(
    //     //       itemCount: _contents?.length ?? 0,
    //     //       itemBuilder: (BuildContext context, int index) {
    //     //         return Expanded(child: Text(_contents[index]));
    //     //       },
    //     //     ),
    //     //     const SizedBox(height: 16),
    //         TextField(
    //           controller: _content,
    //           minLines: 4,
    //           maxLines: 5,
    //           onChanged: (value) {
    //             setState(() {});
    //           },
    //           decoration: const InputDecoration(
    //             hintText: 'Please let us know details about your problems',
    //             hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
    //             contentPadding: EdgeInsets.all(12),
    //             border: OutlineInputBorder(
    //                 borderSide: BorderSide(color: Colors.grey),
    //                 borderRadius: BorderRadius.all(Radius.circular(16))),
    //           ),
    //         ),
    //     //   ],
    //     // ),
    //   ),
    // );
  }
}

