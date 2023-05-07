import 'package:csc13118_mobile/chatGPT/widget/TextAndVoiceField.dart';
import 'package:csc13118_mobile/chatGPT/widget/chatItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../providers/ChatProvider.dart';

class ChatGPT extends StatefulWidget {
  const ChatGPT({Key? key}) : super(key: key);

  @override
  State<ChatGPT> createState() => ChatGPTStage();
}

class ChatGPTStage extends State<ChatGPT> {


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
          'Chat with GPT',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            //letterSpacing: 1.0,
            color: Colors.blue[600],
          ),
        ),
      ),
      body:  Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref , child) {
                final chats = ref.watch(chatsProvider);
                return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) => ChatItem(text: chats[index].message, isMe: chats[index].isMe)
                );
              },
            ),
          ),
          const Padding(
              padding: EdgeInsets.all(12.0),
              child: TextAndVoiceField()
          ),
          const SizedBox(
            height: 10,
          )
        ],
      )
    );
  }
}
