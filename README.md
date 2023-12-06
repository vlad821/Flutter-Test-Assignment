
The project is a Flutter application that manages and displays information about multiple houses and their respective floors. Users can add houses, providing details like the building's name and the number of floors. Each house is represented by a button on the main screen. When a house button is pressed, the app navigates to a screen displaying buttons for each floor of the selected house.

The app features a color-changing animation when navigating between floors, simulating an elevator effect. It uses the flutter_local_notifications package to send notifications indicating the current floor of the elevator in the last selected building. The notifications trigger at regular intervals and provide a seamless user experience.

A SQLite database (building_database.db) is utilized to store information about the houses, including their names and the number of floors. The DatabaseHelper class handles database operations, such as inserting new buildings and querying all existing buildings.

The project showcases the integration of native Android functionality into Flutter using MethodChannel. Specifically, it fetches the default ringtone on Android when a notification is received, enhancing the user experience with personalized notification sounds.

The Flutter UI is well-organized, featuring responsive buttons and a visually appealing design. The code is modular, with separate classes for buttons, screens, and database operations, promoting maintainability and readability.

The app handles timer-based animations effectively, providing a smooth transition between floors. It also gracefully manages the disposal of timers to prevent memory leaks and Flutter errors.

The inclusion of a notification system adds a practical touch to the application, enhancing user engagement and interaction. Overall, the project demonstrates proficiency in Flutter development, incorporating both native and custom functionalities seamlessly.





