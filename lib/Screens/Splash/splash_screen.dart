// import 'dart:math' as Math;
import 'dart:math';
import 'dart:math' as math;

import 'package:college_alert_app/Screens/Auth/login_screen.dart';
import 'package:college_alert_app/Screens/Home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _waveCtrl;
  late final AnimationController _glowCtrl;

  bool _showLogo = false;
  bool _showtext = false;

  @override
  void initState() {
    _waveCtrl = AnimationController(vsync: this, duration: Duration(seconds: 8))
      ..repeat(reverse: true);

    _glowCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);

    Future<void>.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showLogo = true;
        });
      }
    });
    Future<void>.delayed(Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showtext = true;
        });
      }
    });

    //Navigate after a short delay :welcome to home screen
    Future<void>.delayed(Duration(seconds: 4), () async {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(CupertinoPageRoute(builder: (_) => LoginPage()));
    });

    super.initState();
  }

  @override
  void dispose() {
    _waveCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final shorterSide = media.size.shortestSide;

    final logoSize = math.min(160.0, shorterSide * .34);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GradientBg(),
          AnimatedBuilder(
            animation: _waveCtrl,
            builder: (context, _) =>
                CustomPaint(painter: _WavePaint(progress: _waveCtrl.value)),
          ),
          //Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Glowing Logo with fade in animation
                AnimatedOpacity(
                  opacity: _showLogo ? 1 : 0,
                  duration: Duration(microseconds: 700),
                  curve: Curves.easeInOut,
                  child: SplashLogo(size: logoSize, glowValue: _glowCtrl.value),
                ),
                SizedBox(height: 10),
                // App Name and tagline with fade in animation
                AnimatedOpacity(
                  opacity: _showtext ? 1 : 0,
                  duration: Duration(microseconds: 600),
                  curve: Curves.easeInOut,
                  child: Splashtext(
                    appName: 'College Alert App',
                    tagline: 'Stay updated with campus events',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Simple text for Splash screen
class Splashtext extends StatelessWidget {
  const Splashtext({required this.appName, required this.tagline});
  final String appName;
  final String tagline;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appName,
          textAlign: TextAlign.center,
          style: textTheme.displaySmall?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6B2E1A),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 10),
        Text(
          tagline,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
            fontSize: 16,
            color: Color(0xFF8A7F72),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({required this.size, required this.glowValue});

  final double size;
  final double glowValue;

  @override
  // Animated glow using box shadow
  Widget build(BuildContext context) {
    final double blur = 18 + glowValue * 28;
    final double spread = 2 + glowValue * 10;
    final Color glowColor = Color(
      0xFFF3EBDD,
    ).withValues(alpha: (.55 + glowValue * .25).clamp(0.0, 1.0));
    return AnimatedContainer(
      width: size,
      height: size,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: glowColor, blurRadius: blur, spreadRadius: spread),
        ],
      ),

      child: SizedBox(
        width: size * .9,
        height: size * .9,
        child: CircleAvatar(
          backgroundColor: Colors.white.withValues(alpha: 0.05),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),

            child: Image.asset('assets/images/LCWU.png', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

//Gradient Background
class GradientBg extends StatelessWidget {
  const GradientBg();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF8EE), Color(0xFFEADBC8), Color(0xFFC9A36A)],
        ),
      ),
    );
  }
}

class _WavePaint extends CustomPainter {
  _WavePaint({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // Subtle layered sin waves
    final Paint paint1 = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    final Paint paint2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    final Path path1 = Path();
    final Path path2 = Path();
    final double amplitude1 = size.height * 0.06;
    final double amplitude2 = size.height * 0.04;
    final double yBase1 = size.height * 0.72;
    final double yBase2 = size.height * 0.78;

    path1.moveTo(0, yBase1);
    path2.moveTo(0, yBase2);

    for (double x = 0; x <= size.width; x += 2) {
      final double t = (x / size.width) * 2 * pi;
      final double y1 =
          yBase1 + math.sin(t + progress * 2 * math.pi) * amplitude1;
      final double y2 =
          yBase2 + math.sin(t * 1.5 + progress * 2 * math.pi) * amplitude2;

      path1.lineTo(x, y1);
      path2.lineTo(x, y2);
    }
    path1
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    path2
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant _WavePaint oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
