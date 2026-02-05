import 'package:flutter/material.dart';

class StreakWidget extends StatefulWidget {
  const StreakWidget({super.key});

  @override
  State<StreakWidget> createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  final int _streakDays = 5;
  bool _isFrozen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orangeAccent.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: Colors.orangeAccent),
          const SizedBox(width: 5),
          Text(
            '$_streakDays Day Streak',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                _isFrozen = !_isFrozen;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isFrozen
                        ? 'Streak Frozen! Take a break.'
                        : 'Streak Unfrozen!',
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _isFrozen ? Colors.blue : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.ac_unit,
                size: 16,
                color: _isFrozen ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
