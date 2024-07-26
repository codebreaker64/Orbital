import 'package:flutter/material.dart';

Widget musictile({
  required String title,
  required String singer,
  required String cover,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset(cover, fit: BoxFit.cover),
          ),
          const SizedBox(width: 30.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5.0),
              Text(
                singer,
                style: const TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
