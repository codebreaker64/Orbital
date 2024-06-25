import 'package:flutter/material.dart';
import 'package:orbital/Journal/journalentry.dart';
import 'package:orbital/music/music.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:orbital/pages/companion.dart';
import 'package:orbital/pages/custom_avatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //default index of 0
  int _selectedIndex = 0;
  //laying out all the icons in the nav bar
  static List<Widget> body = <Widget>[
    Text('Dashboard Page'),
    Text('Advice Page'),
    Text('Companion Page'),
    Text('Music Page'),
    Text('Journal'),
  ];

//ontap action.
  void _onItemTapped(int index) {
    //Journal index is at 4 so once we click the icon at index 4 the page will open up
    if (index == 3) {
      conte
    }
    if (index == 2) {
      // Journal tab index
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Companion()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  String userName = "";

  final supabase = Supabase.instance.client;
  final List<String> imagePaths = [
    "images/carousel1.png",
    "images/carousel2.png",
    "images/carousel3.png",
  ];

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future<void> getUserName() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final response = await supabase
          .from('User')
          .select('name')
          .eq('email', user.email!)
          .single();
      setState(() {
        userName = response['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //first article link
    final Uri s = Uri.parse(
        "https://www.fulcrumfitness.com/blog/10-benefits-of-going-to-the-gym");
    Future<void> _launchURL() async {
      if (!await launchUrl(s)) {
        throw Exception('Could not launch $s');
      }
    }

//second article link
    final Uri s1 = Uri.parse(
        "https://www.medicalnewstoday.com/articles/154543#definition");
    Future<void> _launchURL1() async {
      if (!await launchUrl(s1)) {
        throw Exception('Could not launch $s1');
      }
    }

    //third article link:
    final Uri s2 = Uri.parse(
        "https://www.channelnewsasia.com/singapore/singapore-struggle-mental-health-issues-stress-emotions-work-studies-wellness-3883091");
    Future<void> _launchURL2() async {
      if (!await launchUrl(s2)) {
        throw Exception('Could not launch $s2');
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 275,
                      top: 50), // Match this value to align with the Text
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomAvatar()),
                      );
                    },
                    child: FluttermojiCircleAvatar(
                      backgroundColor: const Color(0xFF20795E), // Optional background color
                      radius: 60, // Optional radius
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70.0, left: 15.0),
                  child: Text(
                    'Welcome back,' + userName + '\nHow are you feeling today?',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: CarouselSlider(
                  items: imagePaths.map((path) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    enableInfiniteScroll: true,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40.0),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 10.0,
                      left: 30.0,
                      child: Text("New Articles",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold))),
                  Positioned(
                    top: 50.0, // Adjust the top position
                    left: 30.0, // Adjust the left position
                    width: 100, // Adjust the width of the image
                    height: 70.0, // Adjust the height of the image
                    child: Image.asset(
                      'images/gym.jpg',
                      fit: BoxFit
                          .cover, // Adjust how the image should fit within the space
                    ),
                  ),
                  Positioned(
                      top: 50,
                      left: 150,
                      child: TextButton(
                        onPressed: () {
                          // Define the action to be performed on button press
                          _launchURL();
                        },
                        child: Text(
                          '10 Benefits of Going to\n the Gym',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      )),

                  //second section of the article
                  Positioned(
                    top: 150.0, // Adjust the top position
                    left: 30.0, // Adjust the left position
                    width: 100, // Adjust the width of the image
                    height: 70.0, // Adjust the height of the image
                    child: Image.asset(
                      'images/health.png',
                      fit: BoxFit
                          .cover, // Adjust how the image should fit within the space
                    ),
                  ),
                  Positioned(
                      top: 150,
                      left: 150,
                      child: TextButton(
                        onPressed: () {
                          // Define the action to be performed on button press
                          _launchURL1();
                        },
                        child: Text(
                          'What is mental health?',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      )),

                  //third section of the article
                  Positioned(
                    top: 250.0, // Adjust the top position
                    left: 30.0, // Adjust the left position
                    width: 100, // Adjust the width of the image
                    height: 70.0, // Adjust the height of the image
                    child: Image.asset(
                      'images/stress.jpg',
                      fit: BoxFit
                          .cover, // Adjust how the image should fit within the space
                    ),
                  ),
                  Positioned(
                      top: 240,
                      left: 150,
                      child: TextButton(
                        onPressed: () {
                          // Define the action to be performed on button press
                          _launchURL2();
                        },
                        child: Text(
                          'Why do people in Singapore \nstruggle with mental health\nissue?',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.contact_support), label: 'Mediatation'),
            BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Companion'),
            BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Music'),
            BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Journal')
          ],
          //looking at curretindex and selected index.
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          backgroundColor: Color(0xFFABEDE2),
          selectedItemColor: Color(0xFF20795E),
          unselectedItemColor: Color(0xFF000000),

          ///onItemtapped item.
          onTap: _onItemTapped),
    );
  }
}
