Project Documentation
Tasks that needed to be done:
Setup Project:
Created my project:


My mobile emulator is Pixel 2 API 28


And I have the following project structure:
Since the test task is not large, that's why I have such a modest architecture


Design Implementation:

Implement screens according to the provided design: https://www.figma.com/file/3b1hEkkrFN03FAMdMF7Skb/Test-for-Flutter?type=design&node-id=0-1&mode=design&t=7mWGBo7ZFvqOeIqS-0.






SQLite Database:
Create SQLite tables for buildings and the number of floors.
// database_helper.dart
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'building_database.db';
  static final _databaseVersion = 1;

  static final tableBuildings = 'buildings';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnFloors = 'floors';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // This opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableBuildings (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnFloors INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Insert a building into the database
  Future<int> insertBuilding(String name, int floors) async {
    Database db = await instance.database;
    return await db.insert(tableBuildings, {
      columnName: name,
      columnFloors: floors,
    });
  }

  // Get all buildings from the database
  Future<List<Map<String, dynamic>>> queryAllBuildings() async {
    Database db = await instance.database;
    return await db.query(tableBuildings);
  }
}


Database Properties:

_databaseName: Name of the SQLite database file.
_databaseVersion: Version of the database.
Table Properties:

tableBuildings: Name of the database table.
columnId, columnName, columnFloors: Column names in the table.
Singleton Pattern:

_privateConstructor: A private constructor to enforce the singleton pattern.
instance: The single instance of the DatabaseHelper class.
Database Initialization:

_initDatabase: Opens or creates the SQLite database file.
Table Creation:

_onCreate: SQL code to create the database table when the database is first created.
Helper Methods:

insertBuilding: Inserts a new building into the database.
queryAllBuildings: Retrieves all buildings from the database.
This class provides a convenient interface for interacting with an SQLite database in a Flutter application. The singleton pattern ensures that only one instance of the database helper is created, and it exposes methods for common database operations.

MethodChannel Integration:
I tried to complete this task, but I failed to complete it at the end. At least, I tried, though I'm not sure it makes sense
Android (Kotlin)
Fetch Default Ringtone Logic:

The getDefaultRingtone function is implemented in Kotlin. This function retrieves the default ringtone URI using Android's RingtoneManager and then obtains the title of the ringtone.
MethodChannel Handler Setup:

The MethodChannel is set up in the MainActivity.kt to handle Flutter's method calls.
When Flutter invokes the method named "getDefaultRingtone," the handler calls the getDefaultRingtone function and sends back the result to Flutter using result.success.
package com.example.flutter_application_1

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
import android.content.ContentResolver
import android.content.Context
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri

private fun getDefaultRingtone(context: Context): String {
    val contentResolver: ContentResolver = context.contentResolver
    val defaultRingtoneUri: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
    val defaultRingtone: Ringtone = RingtoneManager.getRingtone(context, defaultRingtoneUri)
    return defaultRingtone.getTitle(context).toString()
}
MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "ringtone")
    .setMethodCallHandler { call, result ->
        if (call.method == "getDefaultRingtone") {
            val defaultRingtone = getDefaultRingtone(this)
            result.success(defaultRingtone)
        } else {
            result.notImplemented()
        }
    }

}

Flutter
MethodChannel Setup in Dart:

In Flutter, a MethodChannel named "ringtone" is created to communicate with the native Android part.
The getDefaultRingtone method is defined in Dart, which invokes the native method using _channel.invokeMethod('getDefaultRingtone').
Invoke Native Method in Flutter:

In your Flutter Dart code, you can call RingtoneService().getDefaultRingtone() to initiate the communication with the native Android part.
The result of the native method call (the default ringtone) is then processed or used in your Flutter app.

import 'package:flutter/services.dart';

class RingtoneService {
  static const MethodChannel _channel = MethodChannel('ringtone');

 Future<String?> getDefaultRingtone() async {
  try {
    final String? result =
        await _channel.invokeMethod('getDefaultRingtone');
    return result;
  } on PlatformException catch (e) {
    print("Error: ${e.message}");
    return null;
  }
}

}


Background Notification Logic:

Implement background notification logic:
Send a notification every minute indicating the current floor of the elevator in the last selected building in the application.
1.My function that implement background notification logic:

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
This function, startColorChangeTimer, is responsible for initiating a timer that changes the color of the elevator buttons in a simulated elevator journey. Here's a general overview of what happens in this function:

Timer Initialization: It starts by defining a constant duration representing the time interval for each step of the elevator journey (in this case, 3 seconds). It also initializes currentIndex to 0, which represents the current floor.

Timer Cancellation: If there's an existing timer, it cancels it. This is important to prevent multiple timers from running concurrently.

Timer Periodic Execution: It sets up a periodic timer that executes the provided callback function every duration seconds.

State Update within setState: In each timer iteration, it updates the state of the widget using setState. This ensures that the UI is rebuilt, reflecting the changes in button colors.

Button Color Update: It iterates through all the elevator buttons (floorButtons) and resets their colors to the default (Color(0xFFE6E6E6)).

Active Button Color Change: It updates the color of the button corresponding to the current floor (currentIndex + 1) to a specific color (Color(0xFF3B8642)) if it matches the selected floor; otherwise, it uses a different color (Color(0xFFCAC316)).

Notification: It sends a notification indicating the current floor.

Index Increment: It increments the currentIndex to simulate the elevator moving to the next floor.

Timer Cancellation on Completion: If the elevator reaches the selected floor, it cancels the timer to stop further updates.

In summary, this function orchestrates the simulation of an elevator journey by changing the colors of elevator buttons at specified intervals and sending notifications. The setState ensures that the changes are reflected in the UI.

Implementing background notification logic involves setting up a background task or a periodic task that runs even when the application is in the background. To achieve this in Flutter, you can use the android_alarm_manager plugin for Android or flutter_background_service for both Android and iOS.

Here's a high-level overview of the steps involved in implementing background notification logic for sending periodic notifications about the current floor of the elevator:

2. Add Dependencies:
First, added the necessary dependencies to my pubspec.yaml file:


3. Implement Background Task:
 This tasks will be responsible for sending notifications.

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
This function, sendNotification, is responsible for sending a notification to the user indicating the current floor of the elevator. Here's a breakdown of what's happening in this function:

Notification Details Configuration:

AndroidNotificationDetails: It defines the specific details for the Android platform, such as channel ID, channel name, importance, and priority.
NotificationDetails: It encapsulates platform-specific notification details. In this case, it includes the Android-specific details.
Notification Display:

flutterLocalNotificationsPlugin.show: This method is used to display the notification.
Parameters:
0: Notification ID, a unique identifier for the notification.
'Elevator Notification': The title of the notification.
'Current Floor: $currentFloor': The content or message of the notification, indicating the current floor.
platformChannelSpecifics: The platform-specific notification details configured earlier.
Asynchronous Execution:

async and await: The function is marked as asynchronous (async) because showing a notification might involve operations that could take some time, and it doesn't want to block the main thread.
In summary, this function sets up the details of the notification, including the title, content, and platform-specific settings. Then, it uses the flutterLocalNotificationsPlugin to display the notification with the specified details, including the current floor information.

4.Results:
                                
Project Submission:

Share the results of the assignment by providing a link to the public Git repository.
My Link:
https://github.com/vlad821/Flutter-Test-Assignment.git
