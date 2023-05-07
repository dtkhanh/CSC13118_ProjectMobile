import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatItem extends StatelessWidget {
  final String text;
  final bool isMe;
  const ChatItem({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!isMe) IconChat(isMe: isMe),
          if(!isMe) SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15),
            constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width * 0.6),
            decoration: BoxDecoration(
              color: isMe? Theme.of(context).colorScheme.secondary : Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft:  Radius.circular(isMe ? 15 :0),
                bottomRight:  Radius.circular(isMe? 0: 15),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          if(isMe) SizedBox(width: 15),
          if(isMe) IconChat(isMe: isMe),
        ],
      ),
    );
  }
}

class IconChat extends StatelessWidget {
  const IconChat({
    super.key,
    required this.isMe,
  });

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: isMe? Theme.of(context).colorScheme.secondary : Colors.grey.shade800,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft:  Radius.circular(isMe ? 0 :15),
              bottomRight:  Radius.circular(isMe? 15: 0),
            )
        ),
        // child: Icon(isMe? Icons.person: Icons.computer, color: Theme.of(context).colorScheme.onSecondary,),
        child: isMe?  Icon( Icons.person, color: Theme.of(context).colorScheme.onSecondary,)  : SvgPicture.asset(
            'assets/images/my_icon.svg',
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.onSecondary
        )
    );
  }
}