import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIHandler {
  final _openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 50)));

  Future<String?> getResponse(String message) async {
    try {
      print("getResponse");
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": message})
      ], maxToken: 3500, model:ChatModel.gptTurbo);

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message?.content.trim();
      }
      return 'Some thing went wrong';
    } catch (e) {
      return 'Bad response';
    }
  }

  // void dispose() {
  //   _openAI.close();
  // }
}