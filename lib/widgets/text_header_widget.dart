import 'package:flutter/material.dart';

class TextWidgetHeader extends StatelessWidget {
  String title;
  TextWidgetHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.amber,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Text(
          title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Signatra',
            fontSize: 30,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
