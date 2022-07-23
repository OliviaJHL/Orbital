import 'dart:math';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController animeController;
  late Animation<double> animation_rotation;
  late Animation<double> animation_in;
  late Animation<double> animation_out;

  final double initRadius = 35.0;

  double radius = 0.0;

  @override
  void initState() {
    super.initState();

    animeController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: animeController,
        curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_in = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animeController,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_out = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animeController,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    animeController.addListener(() {
      setState(() {
        if (animeController.value >= 0.75 && animeController.value <= 1.0) {
          radius = animation_in.value * initRadius;
        } else {
          radius = animation_out.value * initRadius;
        }
      });
    });

    animeController.repeat();
  }

  void dispose() {
    animeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
            children: <Widget>[
              Dot(
                radius: 30.0,
                color: Color(0xFFFCC25E),
              ),
              Transform.translate(
                offset: Offset(cos(pi / 3) * radius, sin(pi / 3) * radius),
                child: Dot(
                  radius: 12.0,
                  color: Color(0xFF5375CF),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(2 * pi / 3) * radius, sin(2 * pi / 3) * radius),
                child: Dot(
                  radius: 12.0,
                  color: Color(0xFF8EA8BF),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(3 * pi / 3) * radius, sin(3 * pi / 3) * radius),
                child: Dot(
                  radius: 12.0,
                  color: Color(0xFF6997BF),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(4 * pi / 3) * radius, sin(4 * pi / 3) * radius),
                child: Dot(
                  radius: 12.0,
                  color: Color(0xFF5483BF),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(5 * pi / 3) * radius, sin(5 * pi / 3) * radius),
                child: Dot(
                  radius: 12.0,
                  color: Color(0xFF5483BF),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(6 * pi / 3) * radius, sin(6 * pi / 3) * radius),
                child: Dot(
                  radius: 12.0,
                  color: Color(0xFF3F77BF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}
