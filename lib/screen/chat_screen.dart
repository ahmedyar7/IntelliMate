import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intellimate/model/message_model.dart';
import 'package:intellimate/provider/msg_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../utils/util_helper.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  String query;
  ChatScreen({super.key, required this.query});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var chatBoxController = TextEditingController();
  List<MessageModel> listMsg = [];

  /// Time format
  DateFormat dateFormat = DateFormat().add_jm();

  @override
  void initState() {
    super.initState();

    /// Send initial query when the screen opens
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MessageProvider>(context, listen: false)
          .sendMessage(message: widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icon/logo.png", height: 30),
            Text.rich(
              TextSpan(
                text: " Intelli",
                style: mTextStyle25(fontColor: Colors.white),
                children: [
                  TextSpan(
                    text: "Mate",
                    style: mTextStyle25(fontColor: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Provider.of<MessageProvider>(context, listen: false)
                        .stopTyping();
                  },
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          /// ---------------- Chat List ----------------------- ///
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (_, provider, child) {
                listMsg = provider.listMessage;
                return ListView.builder(
                  reverse: true,
                  itemCount: listMsg.length,
                  itemBuilder: (context, index) {
                    return listMsg[index].sendId == 0
                        ? userChatBox(listMsg[index])
                        : botChatBox(listMsg[index], index); //
                  },
                );
              },
            ),
          ),

          /// Chat box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: chatBoxController,
              style: mTextStyle18(fontColor: Colors.white70),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mic, color: Colors.white),
                suffixIcon: Consumer<MessageProvider>(
                  builder: (context, provider, child) {
                    return InkWell(
                      onTap: () {
                        if (provider.isTyping) {
                          provider.stopTyping(); // Stop response generation
                        } else {
                          if (chatBoxController.text.trim().isNotEmpty) {
                            provider.sendMessage(
                                message: chatBoxController.text.trim());
                            chatBoxController.clear();
                          }
                        }
                      },
                      child: Icon(
                        provider.isTyping
                            ? Icons.stop_circle_outlined
                            : Icons.send,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                hintText: "Write a question!",
                hintStyle: mTextStyle18(fontColor: Colors.white38),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Right Side - User Chat Box
  Widget userChatBox(MessageModel msgModel) {
    var time = dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sendAt!)));
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
            bottomLeft: Radius.circular(21),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msgModel.msg!,
              style: mTextStyle18(fontColor: Colors.white70),
            ),
            Text(
              time,
              style: mTextStyle11(
                fontColor: Colors.white38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Left Side - Bot Chat Box
  Widget botChatBox(MessageModel msgModel, int index) {
    var time = dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sendAt!)));
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 114, 141, 247),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
            bottomRight: Radius.circular(21),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Bot Message
            /// Bot Message
            msgModel.isRead!
                ? MarkdownBody(
                    data: msgModel.msg!,
                    styleSheet: MarkdownStyleSheet(
                      p: mTextStyle18(fontColor: Colors.black87),
                      code: const TextStyle(
                        backgroundColor: Colors.black12,
                        color: Colors.deepOrange,
                        fontFamily: 'monospace',
                      ),
                    ),
                  )
                : DefaultTextStyle(
                    style: mTextStyle18(fontColor: Colors.black87),
                    child: Consumer<MessageProvider>(
                      builder: (context, provider, _) {
                        if (msgModel.isRead! || !provider.isTyping) {
                          return MarkdownBody(
                            data: msgModel.msg!,
                            styleSheet: MarkdownStyleSheet(
                              p: mTextStyle18(fontColor: Colors.black87),
                              code: const TextStyle(
                                backgroundColor: Colors.black12,
                                color: Colors.deepOrange,
                                fontFamily: 'monospace',
                              ),
                            ),
                          );
                        } else {
                          return AnimatedTextKit(
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            isRepeatingAnimation: false,
                            onFinished: () {
                              provider.updateMessageRead(index);
                            },
                            animatedTexts: [
                              TypewriterAnimatedText(
                                msgModel.msg!,
                                textStyle:
                                    mTextStyle18(fontColor: Colors.black87),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),

            /// Timestamp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icon/logo.png",
                      height: 30,
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: msgModel.msg!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Text copied to clipboard!",
                              style: mTextStyle18(fontColor: Colors.white70),
                            ),
                            backgroundColor: Colors.black38.withOpacity(0.8),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.copy_rounded,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  time,
                  style: mTextStyle15(
                    fontColor: Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
