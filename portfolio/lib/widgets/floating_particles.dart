import 'dart:math';
import 'package:flutter/material.dart';

class FloatingParticles extends StatefulWidget {
  const FloatingParticles({super.key});

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    for (int i = 0; i < 60; i++) {
      _particles.add(Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 3 + 1,
        speed: _random.nextDouble() * 2 + 0.5,
        opacity: _random.nextDouble() * 0.6 + 0.2,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            particles: _particles,
            animationValue: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  double x, y, size, speed, opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;

  ParticlePainter({
    required this.particles,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (var particle in particles) {
      // 🔄 Angle rotation
      final angle =
          animationValue * 2 * pi * particle.speed + (particle.x * 2 * pi);

      // 🌀 Spiral inward (black hole effect)
      final baseRadius =
          (particle.y * min(size.width, size.height)) * 0.6;

      final radius =
          baseRadius * (1 - animationValue); // shrinking radius

      final dx = center.dx + cos(angle) * radius;
      final dy = center.dy + sin(angle) * radius;

      // ⭐ Slight glow near center
      final glow = (1 - (radius / baseRadius)).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = Colors.white.withOpacity(
          (particle.opacity + glow * 0.8).clamp(0.0, 1.0),
        )
        ..style = PaintingStyle.fill;

      if (glow > 0.7) {
        paint.maskFilter =
            const MaskFilter.blur(BlurStyle.normal, 8);
      }

      canvas.drawCircle(
        Offset(dx, dy),
        particle.size + glow * 2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}