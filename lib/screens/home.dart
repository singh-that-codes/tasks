import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_cruds/styles/colors.dart';
import 'package:fire_cruds/services/firestore.dart';
import 'package:fire_cruds/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key})
      : super(key: key); // Added missing key parameter and fixed super call

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
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
              titleController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            },
            child: const Text('Create Note'),
          )
        ],
      ),
    );
  }

  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        shadowColor: AppColors.beige,
        title: Text("Noter", style: AppStyles.title),
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
                DocumentSnapshot document = notesList[index];
                String docID = document.id;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];
                Timestamp time = data['timestamp'];

                return Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 12, left: 4, right: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(2.5),
                      border: Border.all(
                          //color: AppColors.beige,
                          //width: 1.0,
                          ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            done = !done;
                          });
                        },
                        icon: done
                            ? Icon(Icons.radio_button_checked,
                                color: AppColors.applegreen)
                            : Icon(Icons.radio_button_unchecked),
                        color: AppColors.grey,
                      ),
                      title: Text(noteText,
                          style: GoogleFonts.aladin(color: AppColors.beige)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.update, color: AppColors.beige),
                            onPressed: () {
                              openNoteBox(docID: docID);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: AppColors.beige),
                            onPressed: () {
                              firestoreService.deleteNote(docID);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
