import 'dart:math';

import 'package:flutter/material.dart';

class AnimationContainerDemo extends StatelessWidget{
  const AnimationContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MyAnimatedContainer(),
    );
  }
}

class _MyAnimatedContainer extends StatefulWidget{
  const _MyAnimatedContainer({Key? key}) : super(key: key);


  @override
  State<_MyAnimatedContainer> createState() => _MyAnimatedContainerState();
}

class _MyAnimatedContainerState extends State<_MyAnimatedContainer>{

  late double margin;
  late double borderRadius;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    margin = _randomMargin();
    borderRadius = _randomBorderRadius();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
                width: 128,
              height: 128,
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              duration: const Duration(milliseconds: 400),
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    margin = _randomMargin();
                    borderRadius = _randomBorderRadius();
                  });
                }, 
                child: const Text("Change")
            )
          ],
        ),
      ),
    );
  }

  double _randomMargin(){
    return Random().nextDouble() * 64;
  }

  double _randomBorderRadius(){
    return Random().nextDouble() * 64;
  }

}