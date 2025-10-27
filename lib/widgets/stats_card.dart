import 'package:flutter/material.dart';
import '../constants/colors.dart';

class StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.purple, Color(0xFF5F3DC4)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('28', 'Days Active'),
          Container(height: 40, width: 1, color: Colors.white30),
          _buildStatItem('95%', 'On-Time'),
          Container(height: 40, width: 1, color: Colors.white30),
          _buildStatItem('140', 'Total Habits'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}
