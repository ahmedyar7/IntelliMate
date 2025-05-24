import 'package:intellimate/data/remote/api_helper.dart';
import 'package:flutter/cupertino.dart';

import '../model/gemini_response_model.dart';
import '../model/message_model.dart';

class MessageProvider extends ChangeNotifier {
  List<MessageModel> listMessage = [];
  bool isTyping = false;

  sendMessage({required String message}) async {
    isTyping = true;
    notifyListeners();

    try {
      var mData = await ApiHelper().sendMsgApi(msg: message);

      listMessage.insert(
        0,
        MessageModel(
          msg: message,
          sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
          sendId: 0,
        ),
      );

      listMessage.insert(
        0,
        MessageModel(
          msg: GeminiResponseModel.fromJson(mData)
              .candidates![0]
              .content!
              .parts![0]
              .text,
          sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
          sendId: 1,
        ),
      );
    } catch (e) {
      listMessage.insert(
        0,
        MessageModel(
          msg: e.toString(),
          sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
          sendId: 1,
        ),
      );
    }

    isTyping = false;
    notifyListeners();
  }

  void stopTyping() {
    // This just halts the animation/response — adapt to your backend logic
    isTyping = false;
    notifyListeners();
  }

  void updateMessageRead(int index) {
    listMessage[index].isRead = true;
    notifyListeners();
  }

  fetchAllMessage() {
    return listMessage;
  }
}
