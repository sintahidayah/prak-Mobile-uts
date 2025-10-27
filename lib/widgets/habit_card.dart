import 'package:flutter/material.dart';
import '../models/habit_model.dart';
import '../constants/colors.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;

  const HabitCard({required this.habit, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: habit.isCompleted ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: habit.isCompleted
                    ? AppColors.primary
                    : Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Text(
                habit.isCompleted ? '✓' : habit.icon,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration:
                          habit.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Row(
                    children: [
                      Text('🔥', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 5),
                      Text(
                        '${habit.streak} days streak',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
