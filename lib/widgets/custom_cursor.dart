import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:async';

class CustomCursor extends StatefulWidget {
  final Widget child;

  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _cursorPosition = Offset.zero;
  bool _isHovering = false;

  StreamSubscription? _mouseSub;
  DateTime _lastUpdate = DateTime.now();

  void _updateHoverState(bool value) {
    if (_isHovering == value) return;
    setState(() => _isHovering = value);
  }

  @override
  void initState() {
    super.initState();

    // SAFER cursor handling
    try {
      html.document.body?.style.cursor = 'none';
    } catch (_) {}

    // THROTTLED mouse tracking (MAJOR PERFORMANCE FIX)
    _mouseSub = html.document.onMouseMove.listen((event) {
      final now = DateTime.now();

      // throttle ~60fps
      if (now.difference(_lastUpdate).inMilliseconds < 16) return;

      _lastUpdate = now;

      final newPos = Offset(
        event.client.x.toDouble(),
        event.client.y.toDouble(),
      );

      if (!mounted) return;

      setState(() {
        _cursorPosition = newPos;
      });
    });
  }

  @override
  void dispose() {
    _mouseSub?.cancel();

    try {
      html.document.body?.style.cursor = 'auto';
    } catch (_) {}

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHoverState(true),
      onExit: (_) => _updateHoverState(false),

      child: Stack(
        children: [
          widget.child,

          IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: _isHovering ? 40 : 20,
              height: _isHovering ? 40 : 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                border: Border.all(
                  color: const Color(0xFF6366F1),
                  width: 2,
                ),
              ),
              transform: Matrix4.translationValues(
                _cursorPosition.dx - (_isHovering ? 20 : 10),
                _cursorPosition.dy - (_isHovering ? 20 : 10),
                0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}