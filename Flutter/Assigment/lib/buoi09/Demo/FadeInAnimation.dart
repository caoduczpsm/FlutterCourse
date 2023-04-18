
import 'package:flutter/material.dart';

class _FadeInAnimation extends StatefulWidget {
  const _FadeInAnimation({super.key});

  @override
  State<_FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<_FadeInAnimation>{

  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }



}