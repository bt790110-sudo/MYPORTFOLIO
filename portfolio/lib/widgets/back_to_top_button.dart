import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BackToTopButton extends StatefulWidget {
  final ScrollController controller;
  
  const BackToTopButton({super.key, required this.controller});

  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _isVisible = widget.controller.offset > 300;
    });
  }

  void _scrollToTop() {
    widget.controller.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }
@override
Widget build(BuildContext context) {
  return Positioned(            // ✅ Positioned moved to outside
    bottom: 30,
    right: 30,
    child: AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: const Color(0xFF6366F1),
          child: const Icon(Icons.arrow_upward, color: Colors.white),
        ).animate(
          effects: const [ScaleEffect(), FadeEffect()],
        ),
      ),
    ),
  );
}
  
}