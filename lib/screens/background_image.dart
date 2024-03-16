import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundImageScreen extends StatelessWidget {
  const BackgroundImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String imageUrl =
        "https://picsum.photos/" + width.toString() + "/" + (height).toInt().toString();
    return Scaffold(
        body: Stack(
          children: [
            Image.network(
              imageUrl,
            ),
            Opacity(
              opacity: 0.4,
              child: Container(
                width: width,
                height: height,

                decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        begin:Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.teal, Colors.green]
                    )
                ),
              ),
            ),
            Positioned(child: Align(
              alignment: Alignment.center,
              child: Text("welcome flutter, hello world " ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 59,
                  fontWeight: FontWeight.w900,
                ),),
            ))
          ],
        ));


  }
}
