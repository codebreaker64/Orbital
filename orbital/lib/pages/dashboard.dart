import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'depression_api.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final supabase = Supabase.instance.client;
  final _nameController = TextEditingController();
  final List<String> imagePaths = [
    "images/uplift.jpg",
    "images/thomas.jpg",
    "images/happy.jpg",
  ];

  Future<void> fetchDepressionData() async {
    try {
      final api = DepressionAPI(); // Create an instance of DepressionAPI
      final data = await api.fetchDepressionData(); // Call the instance method
      // Handle fetched data as needed
      print(data);
    } catch (e) {
      // Handle error
      print('Error fetching depression data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDepressionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0, left: 15.0),
                    child: Text(
                      'Welcome back,\nHow are you feeling today?',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: CarouselSlider(
                        items: imagePaths.map((path) {
                          return Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Image.asset(
                                path,
                                fit: BoxFit.cover,
                                width: 1000.0,
                              ),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          enableInfiniteScroll: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 25.0),
              child: CircleAvatar(
                radius: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
