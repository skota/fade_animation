import 'package:flutter/material.dart';

void main() => runApp(AnimationPage());

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> opacityAnimation;
  AnimationController animCtrl;

  @override
  void initState() {
    super.initState();

    animCtrl = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    //now setup a curve
    final curvedAnimation = CurvedAnimation(
      parent: animCtrl,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
    );

    // use tween to animate curves -
    opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    //setstate is the listener..when animation values change --rebuild
    animCtrl.addListener(() {
      setState(() {});
    });

    //we also want to listen to when the animation status changes
    // status cane be - dismissed, forward, completed, reversed
    animCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animCtrl.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animCtrl.forward();
      }
    });

    //start the animation
    animCtrl.forward();
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedOpacity(
            opacity: opacityAnimation.value,
            duration: Duration(seconds: 2),
            child: Text(
              "Fading Text",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
