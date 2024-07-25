import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WellnessTip {
  final String tip;
  final String imagePath;

  WellnessTip({required this.tip, required this.imagePath});
}

final List<WellnessTip> wellnessTips = [
  WellnessTip(
    tip: 'Take a few deep breaths to calm your mind.',
    imagePath: 'images/carousel1.png',
  ),
  WellnessTip(
    tip: 'Practice gratitude by writing down three things you are thankful for.',
    imagePath: 'images/carousel2.jpg',
  ),
  WellnessTip(
    tip: 'Go for a walk and get some fresh air.',
    imagePath: 'images/carousel3.jpg',
  ),
  WellnessTip(
    tip: 'Spend time with loved ones.',
    imagePath: 'images/carousel4.jpg',
  ),
  WellnessTip(
    tip: 'Listen to your favorite music.',
    imagePath: 'images/carousel5.jpg',
  ),
  WellnessTip(
    tip: 'Try a short meditation or mindfulness exercise.',
    imagePath: 'images/carousel6.jpg',
  ),
];

class WellnessCarousel extends StatelessWidget {
  const WellnessCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        autoPlayInterval: const Duration(seconds: 5),
      ),
      items: wellnessTips.map((wellnessTip) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFF800020),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        wellnessTip.imagePath,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      wellnessTip.tip,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}