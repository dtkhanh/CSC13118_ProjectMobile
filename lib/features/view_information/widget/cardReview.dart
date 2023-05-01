import 'package:flutter/material.dart';
import '../../../model/tutor/feedback.dart';
import '../../tutors/widget/viewRatting.dart';

class CardReview extends StatefulWidget {
  final FeedbacksTutor feedBacksTutor;
  const CardReview({super.key, required this.feedBacksTutor});

  @override
  State<CardReview> createState() => _CardReviewStage();

}

class _CardReviewStage extends State<CardReview> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  Card(
      surfaceTintColor: Colors.white,
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical:8, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: CircleAvatar(
                radius: 45,
                child: ClipOval(
                    child: Image.network(
                      widget.feedBacksTutor.firstInfo?.avatar ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children:  [
                      Expanded(child:  Text(
                        widget.feedBacksTutor.firstInfo?.name ?? "",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),),
                      const SizedBox(width: 8),
                      Expanded(child: Text(
                        '${DateTime.now().difference(DateTime.parse(widget.feedBacksTutor.createdAt!)).inDays} days ago',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),),
                    ],
                  ),
                  Ratting(rating: widget.feedBacksTutor.rating?.toDouble() ?? 0,),
                  const SizedBox(height: 4),
                  Text(
                    widget.feedBacksTutor.content ?? ""  ,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.grey),

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

