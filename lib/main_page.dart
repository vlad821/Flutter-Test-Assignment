
import 'package:flutter/material.dart';
import 'package:flutter_application_1/house_screen.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFE6E6E6),
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 96),
            const Text(
              'Test Task',
              style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: 'Inter',
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 55),
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                 color: const Color(0xFFD9D9D9), // Replace gradient with a solid color
                border: Border.all(
                  color: const Color.fromARGB(255, 199, 13, 13),
                  width: 1.0,
                ),
              ),
              child: const Center(
                child: Text(
                  'any image here',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 31),
            ElevatedButton(
              onPressed: () {
                // Navigate to the new screen with buttons
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE6E6E6),
                fixedSize: const Size(228.0, 57.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: const Text(
                'Enter',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF000000),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          const Spacer(), // Added Spacer to push the 'Designed by ...' text to the bottom
            const Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 21, bottom: 16),
                child: Text(
                  'designed by ...',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






