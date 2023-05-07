import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/appSizes.dart';
import '../../call_video/teamView.dart';


class ViewJoin extends StatefulWidget {
  final int total;
  const ViewJoin({super.key, required this.total});
  @override
  State<ViewJoin> createState() => _ViewJoinStage();

}

class _ViewJoinStage extends State<ViewJoin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Upcoming Lesson',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Sizes.p20, color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '2023-03-11  20:00-00:00',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Sizes.p16, color: Colors.white),
              ),
              const  Text(
                ' ( Start in 65:43:51 ) ',
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: Sizes.p12, color: Colors.yellow),
              ),
              gapW4,
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // set the radius here
                  ),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.p16,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),),
                onPressed: () {  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TeamView()),
                ); },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/join.svg",
                      semanticsLabel: 'Logo join',
                      width: 10,
                      height: 10,
                    ),
                    gapW2,
                    const Text('Join', style: TextStyle(fontSize: Sizes.p16))],),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 24),
            child: Text(
              'Total Lesson Time: 4 hours 30 minutes',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Sizes.p12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}