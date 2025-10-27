import 'package:flutter/material.dart';
import '../constants/colors.dart';

class QiblaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Qibla Direction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Qibla Direction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white30, width: 3),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 20,
                    child: Text(
                      '▲',
                      style: TextStyle(fontSize: 40, color: AppColors.accent),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('🕋', style: TextStyle(fontSize: 60)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Text('Direction', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              '294°',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 10),
            Text('West-Northwest', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 40),
            Text(
              '📍 Your Location: Jakarta, Indonesia',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
