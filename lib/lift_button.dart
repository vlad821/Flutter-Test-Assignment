
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LiftButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  bool isActive;
  final int floors;
  late Color buttonColor;
  final Function(int) onLastButtonSelected;

  LiftButton({
    required this.onPressed,
    required this.text,
    required this.isActive,
    required this.floors,
    required this.buttonColor,
    required this.onLastButtonSelected,
  });

  @override
  _LiftButtonState createState() => _LiftButtonState();
}

class _LiftButtonState extends State<LiftButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Call the original onPressed callback
            widget.onPressed();

            // Check if the pressed button is the last one
            if (widget.isActive) {
              // Notify parent when the last button is selected
              widget.onLastButtonSelected(widget.floors);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            fixedSize: Size(228.0, 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              color: widget.isActive
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : Color(0xFF000000),
              fontFamily: 'Inter',
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
