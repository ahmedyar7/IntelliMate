import 'package:flutter/material.dart';
import 'package:intellimate/providers/chat_provider.dart';
import 'package:intellimate/widgets/bottom_chat_feild.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // ---------> CHAT CONTROLLER <----------- //
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            title: Text("Chat With Gemini"),
          ),

          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child:
                        chatProvider.inChatMessages.isEmpty
                            ? const Center(child: Text("No messages Yet"))
                            : ListView.builder(
                              itemCount: chatProvider.inChatMessages.length,
                              itemBuilder: (context, index) {
                                final message =
                                    chatProvider.inChatMessages[index];
                                return ListTile(
                                  title: Text(message.message.toString()),
                                );
                              },
                            ),
                  ),

                  // ----------------> Botton Chat Feild <--------------- //
                  BottomChatFeild(chatProvider: chatProvider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
