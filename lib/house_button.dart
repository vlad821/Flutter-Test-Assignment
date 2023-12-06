
import 'package:flutter/material.dart';

class HouseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text1;
  final String text2;
  final bool isActive;
  final int floors;
  final Color buttonColor;
  final Color textColor;

  HouseButton({
    required this.onPressed,
    required this.text1,
    required this.text2,
    required this.isActive,
    required this.floors,
    required this.buttonColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            fixedSize: Size(228.0, 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isActive ? const Color.fromARGB(255, 0, 0, 0) : textColor,
                  fontFamily: 'Inter',
                ),
              ),
              // SizedBox(width:20),
              Text(
                text2,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isActive ? const Color.fromARGB(255, 0, 0, 0) : textColor,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
