import 'package:flutter/material.dart';
import 'animation.dart'; // Ensure this matches your file name
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Assignment(), // Ensure Assignment is the widget you want to show
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'assignment.dart'; // Import the Assignment widget

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Animated App',
//       home: Assignment(),
//     );
//   }
// }
