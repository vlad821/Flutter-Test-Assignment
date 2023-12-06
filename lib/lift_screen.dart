import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/lift_button.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FloorsScreen extends StatefulWidget {
  final int numberOfFloors;

  FloorsScreen({required this.numberOfFloors});

  @override
  _FloorsScreenState createState() => _FloorsScreenState();
}

class _FloorsScreenState extends State<FloorsScreen> {
  late List<LiftButton> floorButtons;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int? selectedFloor;
  Timer? timer;
  late String defaultRingtone = "Default Ringtone"; // Provide a default value

  @override
  void initState() {
    super.initState();
    floorButtons = List.generate(
      widget.numberOfFloors,
      (index) => LiftButton(
        onPressed: () {
          setState(() {
            selectedFloor = index + 1;
          });
          startColorChangeTimer(index + 1);
        },
        text: 'Floor ${index + 1}',
        isActive: false,
        floors: index + 1,
        buttonColor: index == 0 ? Color(0xFF3B8642) : Color(0xFFE6E6E6),
        onLastButtonSelected: (int floor) {
          sendNotification(floor);
        },
      ),
    );

    // Initialize flutter local notifications
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Fetch the default ringtone when initializing the screen
 
  }



  void startColorChangeTimer(int selectedFloor) {
    const duration = Duration(seconds: 3);
    int currentIndex = 0;

    timer?.cancel();

    timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        for (int i = 0; i < floorButtons.length; i++) {
          floorButtons[i].buttonColor = Color(0xFFE6E6E6);
        }

        floorButtons[currentIndex].buttonColor =
            currentIndex + 1 == selectedFloor ? Color(0xFF3B8642) : Color(0xFFCAC316);

        sendNotification(floorButtons[currentIndex].floors);

        currentIndex++;

        if (currentIndex == selectedFloor) {
          timer.cancel();
        }
      });
    });
  }

  void sendNotification(int currentFloor) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel ID
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Elevator Notification',
      'Current Floor: $currentFloor',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFE6E6E6),
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 113),
            Container(
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Floors',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: floorButtons.length,
                itemBuilder: (context, index) {
                  final button = floorButtons[index];
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: button.onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: button.buttonColor,
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
                          button.text,
                          style: TextStyle(
                            fontSize: 16,
                            color: button.isActive
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : Color(0xFF000000),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  );
                },
              ),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25, bottom: 16),
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
            // Display the default ringtone
           
          ],
        ),
      ),
    );
  }
}
