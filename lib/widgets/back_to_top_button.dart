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
    final shouldShow = widget.controller.offset > 300;

    // WEB OPTIMIZATION: avoid unnecessary rebuilds
    if (shouldShow == _isVisible) return;

    if (!mounted) return;

    setState(() {
      _isVisible = shouldShow;
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
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),

          // FIX: remove redundant Visibility widget
          child: IgnorePointer(
            ignoring: !_isVisible,

            child: Positioned(
              bottom: 30,
              right: 30,

              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: const Color(0xFF6366F1),
                child: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              ).animate(
                effects: const [
                  ScaleEffect(),
                  FadeEffect(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}