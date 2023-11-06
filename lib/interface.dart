// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:imagestorage/databse.dart'; // Ensure the correct import path for your database helper
// import 'dart:io'; // Add this import for File class

// class PhotoListScreen extends StatefulWidget {
//   @override
//   _PhotoListScreenState createState() => _PhotoListScreenState();
// }

// class _PhotoListScreenState extends State<PhotoListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Photo List'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>?>(
//         future: DatabaseHelper.instance.queryAll(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//           final photos = snapshot.data!;
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//             itemCount: photos.length,
//             itemBuilder: (context, index) {
//               final imagePath = photos[index]['imagePath'] as String;
//               return Padding(
//                 padding: EdgeInsets.all(8.0), // Add padding
//                 child: AspectRatio(
//                   aspectRatio: 1.0, // Maintain a 1:1 aspect ratio
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black), // Add border for container
//                     ),
//                     child: Stack(
//                       children: [
//                         Image.file(
//                           File(imagePath), // Use Image.file to display images from file paths
//                           fit: BoxFit.cover, // Adjust the fit to your preference
//                         ),
//                         Positioned(
//                           bottom: 0, // Position the delete button at the bottom
//                           right: 0, // Position the delete button at the right
//                           child: IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () async {
//                               await _deleteImage(imagePath);
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final imagePicker = ImagePicker();
//           final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

//           if (pickedFile != null) {
//             // Save the image path to the database
//             String imagePath = pickedFile.path;
//             await DatabaseHelper.instance.insert(imagePath);
//             // Reload the photo list to display the newly added image
//             setState(() {});
//           }
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

  Future<void> _deleteImage(String imagePath) async {
    await DatabaseHelper.instance.delete(imagePath);
    setState(() {});
  }

import 'package:SnapStore/databse.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';
// Ensure the correct import path for your database helper
import 'dart:io'; // Add this import for File class

class PhotoListScreen extends StatefulWidget {
  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(backgroundColor: Colors.redAccent.shade700,
        title: Center(child: Text('Photo List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: DatabaseHelper.instance.queryAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final photos = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final imagePath = photos[index]['imagePath'] as String;
              return Padding(
                padding: EdgeInsets.all(8.0), // Add padding
                child: GestureDetector(
                 onTap: () {
    _viewFullImage(context, imagePath);
  },
                  child: AspectRatio(
                    aspectRatio: 1.0, // Maintain a 1:1 aspect ratio
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Add border for container
                      ),
                      child: Stack(
                        children: [
                          Image.file(
                            File(imagePath), // Use Image.file to display images from file paths
                            fit: BoxFit.cover, // Adjust the fit to your preference
                          ),
                          Positioned(
                            bottom: 0, // Position the delete button at the bottom
                            right: 0, // Position the delete button at the right
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await _deleteImage(imagePath);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.redAccent.shade700,
        onPressed: () async {
          final imagePicker = ImagePicker();
          final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            // Save the image path to the database
            String imagePath = pickedFile.path;
            await DatabaseHelper.instance.insert(imagePath);
            // Reload the photo list to display the newly added image
            setState(() {});
          }
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  Future<void> _deleteImage(String imagePath) async {
    await DatabaseHelper.instance.delete(imagePath);
    setState(() {});
  }
void _viewFullImage(BuildContext context, String imagePath) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return FullImageScreen(imagePath: imagePath);
      },
    ),
  );
}




}

class FullImageScreen extends StatelessWidget {
  final String imagePath;

  FullImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  appBar: AppBar(backgroundColor: Colors.redAccent.shade700,title: Text("Full Image",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(
                File(imagePath),
                fit: BoxFit.fitHeight,
   
              ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     _restoreImage(imagePath);
              //   },
              //   child: Text('Restore to Gallery'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _restoreImage(String imagePath) {
    // Add logic to restore the image to the gallery here
    // You may use the `image_path` to move the image file to the gallery directory.
  }
}
