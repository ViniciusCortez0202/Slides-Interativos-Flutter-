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

class _ImagemSlidesState extends State<ImagemSlides> {
  String img1 = "images/pic1.jpg";
  String img2 = "images/pic2.jpg";
  String img3 = "images/pic3.jpg";

  next() {
    String aux;

    aux = img1;
    img1 = img3;
    img3 = aux;

    aux = img2;
    img2 = img3;
    img3 = aux;
  }

  before() {
    String aux;
    aux = img2;
    img2 = img1;
    img1 = aux;

    aux = img2;
    img2 = img3;
    img3 = aux;
  }

  @override
  void initState() {
    // TODO: implement initState

    Timer timer = new Timer.periodic(new Duration(seconds: 3), (timer) {
      setState(() {
        next();
      });
    });

    super.initState();
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
              setState(() {
                before();
              });
            },
          ),
        ),
        Expanded(
          child: Image.asset(img1),
        ),
        Expanded(
          flex: 2,
          child: Image.asset(img2),
        ),
        Expanded(
          child: Image.asset(img3),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              setState(() {
                next();
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
