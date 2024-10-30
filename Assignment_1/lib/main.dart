import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CrazyAnimationUI(),
    );
  }
}

class CrazyAnimationUI extends StatefulWidget {
  @override
  _CrazyAnimationUIState createState() => _CrazyAnimationUIState();
}

class _CrazyAnimationUIState extends State<CrazyAnimationUI> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    setState(() {
      if (isAnimating) {
        _controller.stop();
      } else {
        _controller.repeat(reverse: true);
      }
      isAnimating = !isAnimating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Stack(
                children: List.generate(6, (index) {
                  return AnimatedBuilder(
                    animation: _animation,
                    child: _buildAnimatedCircle(index),
                    builder: (context, child) {
                      double position = (index % 2 == 0 ? _animation.value : 1 - _animation.value);
                      return Positioned(
                        left: 100 + sin(position * 2 * pi) * 100,
                        top: 200 + cos(position * 2 * pi) * 100,
                        child: child!,
                      );
                    },
                  );
                }),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Text(
                    'Crazy Animation UI',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'By MD. SOROWAR MAHABUB RABBY',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Center(
                child: ElevatedButton(
                  onPressed: _toggleAnimation,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    isAnimating ? 'Stop Animation' : 'Start Animation',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCircle(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.primaries[index % Colors.primaries.length],
        shape: BoxShape.circle,
      ),
    );
  }
}
