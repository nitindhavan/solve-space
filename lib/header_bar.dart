import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E2E),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Color(0xFF2C2C3E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Notifications and Avatar (right side)

          Container(
            width: 48, // Fixed width for a small square button
            height: 48, // Fixed height for a square shape
            decoration: BoxDecoration(
              color: Color(0xFF2C2C3E), // Background color to match the TextField
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: IconButton(
              onPressed: () {
                // Add your button action here
              },
              icon: Icon(
                Icons.search, // Search icon
                color: Colors.white,
                size: 24, // Icon size
              ),
            ),
          ),

          SizedBox(width: 18,),
          Row(
            children: [
              Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: 16),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150', // Replace with user profile image
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
