
import 'package:flutter/material.dart';

class AnimationDemo extends StatelessWidget{
  const AnimationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MyHome(),
    );
  }
}

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

class _FadeInAnimation extends StatefulWidget {
  const _FadeInAnimation({super.key});

  @override
  State<_FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<_FadeInAnimation> {

  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fade In Animation"),
      ),
      body: Column(
        children: [
          SizedBox(
            child: Image.asset('images/owl.png'),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  opacity = 1;
                });
              },
              child: const Text(
                "Show Details",
                style: TextStyle(color: Colors.blueAccent),
              )
          ),
          AnimatedOpacity
            (opacity: opacity,
            duration: const Duration(seconds: 4),
            child: Column(
              children: const [
                Text("Type: Bird"),
                Text("Type: Owl"),
              ],
            ),
          )
        ],
      ),
    );
  }
}