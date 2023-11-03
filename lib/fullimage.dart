// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'dart:io';

// class FullImageScreen extends StatelessWidget {
//   final String imagePath;

//   FullImageScreen({required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Full Image'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 height: screenHeight * 0.6, // Adjust the value as needed
//                 child: Image.file(
//                   File(imagePath),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the full image screen.
//                     },
//                     child: Text('Close'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';

// class FullImageScreen extends StatelessWidget {
//   final String imagePath;

//   FullImageScreen({required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
     
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width, // Set width to screen width
//                 height: MediaQuery.of(context).size.height * 0.6, // Adjust the value as needed
//                 child: Image.file(
//                   File(imagePath),
//                   fit: BoxFit.cover, // Ensure the image covers the entire container
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the full image screen.
//                     },
//                     child: Text('Close'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
