import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  static const int _focusMinutes = 25;
  int _secondsRemaining = _focusMinutes * 60;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
          _isRunning = false;
          // Could trigger alarm here
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _pauseTimer();
    setState(() {
      _secondsRemaining = _focusMinutes * 60;
    });
  }

  double get _percent {
    return _secondsRemaining / (_focusMinutes * 60);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 12.0,
          percent: _percent,
          // Aesthetics: Soft rounded gradient
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.grey[200]!,
          progressColor: _percent > 0.2
              ? const Color(0xFF6A11CB)
              : Colors.redAccent, // Changes color when low
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time_filled,
                size: 40,
                color: _percent > 0.2
                    ? const Color(0xFF6A11CB)
                    : Colors.redAccent,
              ),
              const SizedBox(height: 5),
              Text(
                _isRunning ? 'Focus' : 'Paused',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                _isRunning
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
              ),
              iconSize: 40,
              color: const Color(0xFF6A11CB),
              onPressed: _isRunning ? _pauseTimer : _startTimer,
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              iconSize: 30,
              color: Colors.grey,
              onPressed: _resetTimer,
            ),
          ],
        ),
      ],
    );
  }
}
