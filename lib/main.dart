import 'package:flutter/material.dart';
import 'dart:async';

class Slides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.green, title: Text("Slides imagens")),
      body: Center(child: ImagemSlides()),
    );
  }
}

class ImagemSlides extends StatefulWidget {
  @override
  _ImagemSlidesState createState() => _ImagemSlidesState();
}

class _ImagemSlidesState extends State<ImagemSlides>
    with SingleTickerProviderStateMixin {
  String img1 = "images/pic1.jpg";
  String img2 = "images/pic2.jpg";
  String img3 = "images/pic3.jpg";

  double opacityImage = 0;
  AnimationController _controller;
  Animation _animation;
  Timer timer;

  next() {
    String aux;

    aux = img1;
    img1 = img3;
    img3 = aux;

    aux = img2;
    img2 = img3;
    img3 = aux;
    _controller.forward();
  }

  before() {
    String aux;

    aux = img2;
    img2 = img1;
    img1 = aux;

    aux = img2;
    img2 = img3;
    img3 = aux;

    _controller.forward();
  }

  @override
  void initState() {
    // TODO: implement initState

    initTimer();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    super.initState();
  }

  initTimer(){
    if(timer != null && timer.isActive) timer.cancel();
    timer = new Timer.periodic(new Duration(milliseconds: 4500), (timer) {
      _controller.reverse();
      Timer(new Duration(milliseconds: 700), () {
        setState(() {
          next();
        });
      });
    });
  }

  imageSlide(String img, int flexValue) {
    return Expanded(
        flex: flexValue,
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(img),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () {
              _controller.reverse();
              Timer(new Duration(milliseconds: 700), () {
                setState(() {
                  before();
                  initTimer();
                });
              });
            },
          ),
        ),
        imageSlide(img1, 1),
        imageSlide(img2, 2),
        imageSlide(img3, 1),
        Container(
          child: IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              _controller.reverse();
              Timer(new Duration(milliseconds: 700), () {
                setState(() {
                  next();
                  initTimer();                  
                });
              });
            },
          ),
        )
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: "Slides app",
    home: Slides(),
  ));
}
