import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/timer_painter.dart';

class CookingTimerScreen extends StatefulWidget {
  const CookingTimerScreen({super.key});

  @override
  _CookingTimerScreenState createState() => _CookingTimerScreenState();
}

class _CookingTimerScreenState extends State<CookingTimerScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _timer;
  int _seconds = 0;
  int _totalSeconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _totalSeconds = _seconds;
    });
    
    _animationController.repeat();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
          _animationController.stop();
          _isRunning = false;
          _showTimerCompleteDialog();
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _animationController.stop();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _animationController.reset();
    setState(() {
      _seconds = 0;
      _totalSeconds = 0;
      _isRunning = false;
    });
  }

  void _showTimerCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Timer Complete!'),
        content: const Text('Your cooking timer has finished.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Timer'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer display
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange[600]!, width: 8),
              ),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: TimerPainter(
                      progress: _totalSeconds > 0 ? _seconds / _totalSeconds : 0,
                      color: Colors.orange[600]!,
                    ),
                    child: Center(
                      child: Text(
                        _formatTime(_seconds),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            
            // Time input
            if (!_isRunning && _seconds == 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeInput('Min', (value) {
                    setState(() {
                      _seconds = (value * 60) + (_seconds % 60);
                    });
                  }),
                  const SizedBox(width: 20),
                  _buildTimeInput('Sec', (value) {
                    setState(() {
                      _seconds = (_seconds ~/ 60) * 60 + value;
                    });
                  }),
                ],
              ),
            
            const SizedBox(height: 40),
            
            // Control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : (_seconds > 0 ? _startTimer : null),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? Colors.red : Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    _isRunning ? 'Pause' : 'Start',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeInput(String label, Function(int) onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          width: 60,
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              int intValue = int.tryParse(value) ?? 0;
              onChanged(intValue);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '0',
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
