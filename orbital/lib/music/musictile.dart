import 'package:flutter/material.dart';

Widget musictile({
  required String title,
  required String singer,
  required String cover,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            child: Image.asset(cover, fit: BoxFit.cover),
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5.0),
              Text(
                singer,
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
