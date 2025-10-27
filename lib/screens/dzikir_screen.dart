import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../controllers/dzikir_controller.dart';
import '../constants/colors.dart';

class DzikirScreen extends StatelessWidget {
  final DzikirController controller = Get.put(DzikirController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Dzikir Counter'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => controller.reset(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  controller.currentDzikir['name'].toString(),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 10),
            Obx(() => Text(
                  controller.currentDzikir['arabic'].toString(),
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )),
            SizedBox(height: 40),
            Obx(() => CustomPaint(
                  size: Size(250, 250),
                  painter: CircularProgressPainter(
                    progress: controller.count.value / controller.target.value,
                  ),
                  child: Container(
                    width: 250,
                    height: 250,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${controller.count.value}',
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'of ${controller.target.value}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () => controller.increment(),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(Icons.touch_app, size: 50),
              ),
            ),
            SizedBox(height: 30),
            Text('Tap to count', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDzikirOption('SubhanAllah', 'سُبْحَانَ اللّٰهِ', 33),
                SizedBox(width: 10),
                _buildDzikirOption('Alhamdulillah', 'الْحَمْدُ لِلّٰهِ', 33),
                SizedBox(width: 10),
                _buildDzikirOption('Allahu Akbar', 'اللّٰهُ أَكْبَرُ', 34),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDzikirOption(String name, String arabic, int target) {
    return Obx(() => GestureDetector(
          onTap: () => controller.selectDzikir(name, arabic, target),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: controller.currentDzikir['name'] == name
                  ? AppColors.primary
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(name, style: TextStyle(fontSize: 12)),
          ),
        ));
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    canvas.drawCircle(center, radius, paint);

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
