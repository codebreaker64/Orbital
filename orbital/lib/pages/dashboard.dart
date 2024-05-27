import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final supabase = Supabase.instance.client;
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:70.0, left: 15.0),
                  child: Text(
                    'Welcome back,' //+ supabase.from('User').select('name')
                    //.eq('id', Supabase.instance.client.auth.currentUser!.id)
                    //.single().toString(), // Changed the body text
                    + '\nHow are you feeling today?',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                /* CarouselSlider(
                  items: [
                    Container()
                  ],
                  options: CarouselOptions(
                      height: 200.0, // Adjust the height of the carousel
                      enlargeCenterPage: true,
                      autoPlay: true, // Set to true for automatic sliding
                      aspectRatio: 16/9, // Adjust aspect ratio
                      autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
                      autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
                      enableInfiniteScroll: true, // Set to false to disable infinite scroll
                  )
                ), */
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 25.0),
              child: CircleAvatar(
                radius:50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
