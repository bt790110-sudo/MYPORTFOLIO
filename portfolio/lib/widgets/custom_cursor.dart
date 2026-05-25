import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'dart:html' as html;

class CustomCursor extends StatefulWidget {
  final Widget child;
  
  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _cursorPosition = Offset.zero;
  bool _isHovering = false;
  
  // Track hover state for interactive elements
  void _updateHoverState(bool isHovering) {
    if (_isHovering != isHovering) {
      setState(() {
        _isHovering = isHovering;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Hide default cursor
    html.document.body!.style.cursor = 'none';
    
    // Track mouse movement
    html.document.onMouseMove.listen((event) {
      setState(() {
        _cursorPosition = Offset(event.client.x.toDouble(), event.client.y.toDouble());
      });
    });
    
    // Track hover on interactive elements
    _setupHoverTracking();
  }
  
  void _setupHoverTracking() {
    // Add hover listeners to all interactive elements
    final interactiveSelectors = [
      'button',
      'a',
      '[role="button"]',
      '.interactive',
      'input',
      'textarea',
      '[onclick]'
    ];
    
    for (var selector in interactiveSelectors) {
      final elements = html.document.querySelectorAll(selector);
      for (var element in elements) {
        element.onMouseEnter.listen((_) => _updateHoverState(true));
        element.onMouseLeave.listen((_) => _updateHoverState(false));
      }
    }
  }

  @override
  void dispose() {
    // Restore default cursor
    html.document.body!.style.cursor = 'auto';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: Stack(
        children: [
          // Main content with hover detection wrapper
          MouseRegion(
            onEnter: (_) => _updateHoverState(true),
            onExit: (_) => _updateHoverState(false),
            child: widget.child,
          ),
          
          // ✅ FIXED: PortalTarget with required child parameter
          PortalTarget(
            visible: true,
            anchor: const Aligned(
              follower: Alignment.topLeft,
              target: Alignment.topLeft,
            ),
            portalFollower: IgnorePointer(
              ignoring: true,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                width: _isHovering ? 40 : 20,
                height: _isHovering ? 40 : 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                  border: Border.all(
                    color: const Color(0xFF6366F1),
                    width: 2,
                  ),
                  boxShadow: _isHovering
                      ? [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                transform: Matrix4.translationValues(
                  _cursorPosition.dx - (_isHovering ? 20 : 10),
                  _cursorPosition.dy - (_isHovering ? 20 : 10),
                  0,
                ),
              ),
            ),
            // ✅ CRITICAL FIX: Added required child parameter
            child: const SizedBox.shrink(), // Invisible anchor widget
          ),
        ],
      ),
    );
  }
}