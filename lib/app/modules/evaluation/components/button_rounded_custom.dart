import 'package:flutter/material.dart';

class ButtonRoundedCustom extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Function()? onPressed;
  const ButtonRoundedCustom(this.text, this.width, this.height, this.onPressed,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        child: Text(text),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
