import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'dart:math';
import 'package:get/get.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FluttermojiCircleAvatar(
                  radius: 100,
                  backgroundColor: const Color(0xFF20795E),
                ),
              ),
              SizedBox(
                width: min(600, width * 0.85),
                child: Row(
                  children: [
                    Text(
                      "Customize:",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    FluttermojiSaveWidget(
                      child:  ElevatedButton(
                        onPressed: () async{ 
                          await Get.find<FluttermojiController>().setFluttermoji();
                        },
                        child: const Text("Save"),
                      )
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: FluttermojiCustomizer(
                  scaffoldWidth: min(600, width * 0.85),
                  autosave: false,
                  theme: FluttermojiThemeData(
                      primaryBgColor: const Color(0xFFFFFDD0),
                      secondaryBgColor: const Color.fromARGB(255, 73, 155, 93),
                      boxDecoration: const BoxDecoration(boxShadow: [BoxShadow()])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}