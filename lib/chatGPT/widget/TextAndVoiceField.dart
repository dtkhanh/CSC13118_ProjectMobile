import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/chat/chatModel.dart';
import '../../providers/ChatProvider.dart';
import '../../services/chatGPTService.dart';
import 'ToggleButton.dart';
enum InputMode{
  text,
  voice
}


class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  var reply = false;
  final _messageController = TextEditingController();
  AIHandler _openAi = AIHandler();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        reply == false ? Text('')  : Text('Watting'),
        Row(
          children: [
            // _inputMode == InputMode.voice ? ToggleButton(inputMode: _inputMode,): SizedBox(),
            Expanded(child: TextField(
              controller: _messageController,
              onChanged: (value){
                value.isNotEmpty ? setInputMode(InputMode.text) : setInputMode(InputMode.voice);
              },
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
            )),
            const SizedBox(
              width: 06,
            ),
            ToggleButton(
              inputMode: _inputMode,
              sendText: (){
                final mess = _messageController.text;
                _messageController.clear();
                sendTextMessage(mess);
              },
              senVoice: sendVoiceMessage,
            )
          ],
        )
      ],
    );
  }
  void setInputMode(InputMode inputMode){
    setState(() {
      _inputMode = inputMode;
    });
  }
  Future<void> sendTextMessage(String message) async {
    setState(() {
      reply= true;
    });
    addToList(message, true, DateTime.now().toString());
    final aiResponse = await _openAi.getResponse(message);
    addToList(aiResponse!, false, DateTime.now().toString());
    setState(() {
      reply= false;
    });
  }
  void addToList(String message, bool isMe, String id) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(ChatModel(
      id: id,
      message: message,
      isMe: isMe,
    ));
  }
  void sendVoiceMessage(){}
}