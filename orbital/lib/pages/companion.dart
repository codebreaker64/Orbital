import 'chatcontroller.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/get.dart';

class Companion extends StatefulWidget {
  const Companion({super.key});
  @override
  State<Companion> createState() => _CompanionState();
}

class _CompanionState extends State<Companion> {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = chatController.messages[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        message.sender == 'You'
                        ?
                        FluttermojiCircleAvatar(
                          backgroundColor: const Color(0xFF20795E), // Optional background color
                          radius: 20, // Optional radius
                        ):
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/neil.jpg',
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${message.sender}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: message.sender == 'You'
                                      ? Colors.blue
                                      : Colors.red,
                                ),
                              ),
                              Text(message.message),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: KeyboardListener(
                    focusNode: FocusNode(), // Ensure this widget has focus
                    child: TextField(
                      focusNode: chatController.textFocusNode,
                      onSubmitted: (val) {
                        chatController.sendMessage(chatController.textController.text);
                        chatController.textController.clear();
                      },
                      controller: chatController.textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your message...',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (chatController.textController.text.isNotEmpty) {
                      chatController.sendMessage(chatController.textController.text);
                      chatController.textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}