import 'package:flutter/material.dart';
import 'package:intellimate/providers/chat_provider.dart';

class BottomChatFeild extends StatefulWidget {
  const BottomChatFeild({super.key, required this.chatProvider});

  final ChatProvider chatProvider;

  @override
  State<BottomChatFeild> createState() => _BottomChatFeildState();
}

class _BottomChatFeildState extends State<BottomChatFeild> {
  // Controller for input feild
  final TextEditingController textController = TextEditingController();

  // Focur mode for input feild
  final FocusNode textFeildFocus = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    textFeildFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).textTheme.titleLarge!.color!,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // PICK IMAGE
            },
            icon: const Icon(Icons.image),
          ),

          const SizedBox(width: 5),

          Expanded(
            child: TextField(
              focusNode: textFeildFocus,
              controller: textController,
              textInputAction: TextInputAction.send,

              onSubmitted: (String value) {},

              decoration: InputDecoration.collapsed(
                hintText: "Enter a Prompt...",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // SEND A MESSAGE
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_upward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
