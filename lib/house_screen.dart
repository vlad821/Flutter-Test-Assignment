import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/house_button.dart';
import 'package:flutter_application_1/lift_screen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<HouseButton> buttons = [];
  Timer? colorChangeTimer;
  int activeButtonIndex = 0;

  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xFFE6E6E6),
        padding: EdgeInsets.fromLTRB(16.0, 100, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Show the additional container when the first button is pressed
                  showHouseDataForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: Size(228.0, 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Add House',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 35.0), // Add space between buttons
              for (int i = 0; i < buttons.length; i++) buttons[i],
            ],
          ),
        ),
      ),
    );
  }

  void showHouseDataForm() {
    showDialog(
      context: context,
      builder: (context) {
        String enteredBuildingName = "";
        int enteredNumberOfFloors = 0;

        return AlertDialog(
          backgroundColor: Color(0xFFD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.0),
            side: BorderSide(color: Colors.black, width: 2.0),
          ),
          content: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                width: 321,
                height: 161,
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Row(
                      children: [
                        const Text(
                          'Name ',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 50),
                        Container(
                          width: 142,
                          height: 26,
                          child: TextField(
                            onChanged: (value) {
                              enteredBuildingName = value;
                            },
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFE6E6E6),
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        const Text(
                          'Floors count',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 37,
                          height: 26,
                          child: TextField(
                            onChanged: (value) {
                              enteredNumberOfFloors = int.tryParse(value) ?? 0;
                            },
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFE6E6E6),
                              border: InputBorder.none,

                              ///   contentPadding: EdgeInsets.symmetric(vertical: 8),
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 4,
                right: 6,
                child: Row(
                  children: [
                    const Text(
                      "Add House",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(width: 50),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 55),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 8),
              child: ElevatedButton(
                onPressed: () async {
                  await addNewButton(
                      enteredBuildingName, enteredNumberOfFloors);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(98, 24),
                  backgroundColor: Color(0xFFE6E6E6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> addNewButton(String buildingName, int numberOfFloors) async {
    setState(() {
      buttons.add(
        HouseButton(
          onPressed: () {
            setState(() {
              activeButtonIndex = buttons.length - 1;
            });
            showFloorsScreen();
          },
          text1: 'House',
          text2: buildingName,
          isActive: buttons.length - 1 == activeButtonIndex,
          floors: numberOfFloors,
          buttonColor: Color(0xFFE6E6E6),
          textColor: Colors.black,
        ),
      );
    });
  }

  void showFloorsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FloorsScreen(numberOfFloors: buttons[activeButtonIndex].floors),
      ),
    );
  }
}
