import 'package:flutter/material.dart';
import 'package:pytorch_mobile/model.dart';
import 'package:pytorch_mobile/pytorch_mobile.dart';
import 'package:intl/intl.dart'

class Companion extends StatefulWidget {
  const Companion({super.key});

  @override
  State<Companion> createState() => _CompanionState();
}

class _CompanionState extends State<Companion> {

  const Companion({super.key});

  @override
  State<Companion> createState() => _CompanionState();
}

class _CompanionState extends State<Companion> {
  final TextEditingController _controller = TextEditingController();
  late Model _model;
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    _model = await PyTorchMobile.loadModel('assets/model.pt');
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final userMessage = _controller.text;
    setState(() {
      _messages.add(Message(text: userMessage, isUser: true, timestamp: DateTime.now()));
    });

    // Preprocess the input for the model
    List<double> input = _preprocess(userMessage);

    // Run the model and get the output
    List<dynamic> output = await _model.getPrediction(input);

    // Postprocess the output
    String response = _postprocess(output);

    setState(() {
      _messages.add(Message(text: response, isUser: false, timestamp: DateTime.now()));
    });

    _controller.clear();
  }

  List<double> _preprocess(String text) {
    // Implement your preprocessing logic here
    // Convert text to a format suitable for the model
    return [/* ... */];
  }

  String _postprocess(List<dynamic> output) {
    // Implement your postprocessing logic here
    // Convert the model output to a readable string
    return output.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return ListTile(
                  title: Align(
                    alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: message.isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            DateFormat('hh:mm a').format(message.timestamp),
                            style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({required this.text, required this.isUser, required this.timestamp});
}