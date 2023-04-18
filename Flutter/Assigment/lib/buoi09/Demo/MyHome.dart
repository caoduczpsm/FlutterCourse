import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class _MyHome extends StatefulWidget {
  const _MyHome({Key? key}) : super(key: key);

  @override
  State<_MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<_MyHome> with SingleTickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 1.5),
  ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    reverseCurve: Curves.easeOutCirc,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _offsetAnimation,
          child: const Padding(
              padding: EdgeInsets.all(0),
            child: FlutterLogo(
              size: 150,
            ),
          ),
        ),
      ),
    );
  }
}