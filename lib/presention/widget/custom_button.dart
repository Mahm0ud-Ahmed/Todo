import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.title,
    this.width,
    this.onClick,
    this.color,
  }) : super(key: key);

  final String title;
  final Function() onClick;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade100,
            letterSpacing: 0.5,
            wordSpacing: 2,
          ),
        ),
      ),
    );
  }
}
