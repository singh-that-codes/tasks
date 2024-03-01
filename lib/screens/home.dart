import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_cruds/services/firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //firestore object
  final FirestoreService firestoreService = FirestoreService();
  //text controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  //open a dialog box to add content
  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16), // Adding spacing between text fields
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (docID == null) {
                  firestoreService.addNote(
                      titleController.text, descriptionController.text);
                } else {
                  firestoreService.updateNote(
                      docID, titleController.text, descriptionController.text);
                }
                //clear the controller
                titleController.clear();
                descriptionController.clear();

                //close the box
                Navigator.pop(context);
              },
              child: const Text('Create Note'),
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                //get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                //get note from each doc
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                //display as list tile
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.update),
                        onPressed: () {
                          openNoteBox(docID: docID);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          firestoreService.deleteNote(docID);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator if data is still loading
          }
        },
      ),
    );
  }
}
