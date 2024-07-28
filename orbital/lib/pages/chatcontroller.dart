import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

class ChatMessage {
  final String sender;
  final String message;

  ChatMessage({required this.sender, required this.message});
}

class ChatController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();
  final messages = <ChatMessage>[].obs;

  Future<void> sendMessage(String message) async {
    messages.add(ChatMessage(sender: 'You', message: message));

    final response = await http.post(
      Uri.parse('https://fastapi-chatbot-vt2wycnxiq-as.a.run.app/chat/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String botResponse = data['response'];
      messages.add(ChatMessage(sender: 'neil', message: botResponse));
    } else {
      throw Exception('Failed to load data');
    }

    // Request focus on the TextField after sending message
    textFocusNode.requestFocus();
  }
}