import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Map<String, String>> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _sortNotes,
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _clearAllNotes,
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 700),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addNote,
                  ),
                  Text(
                    'Add Note',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]['title'] ?? ''),
                    subtitle: Text(notes[index]['content'] ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNoteAtIndex(index),
                    ),
                    onTap: () => _editNoteAtIndex(context, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shareNotes,
        child: Icon(Icons.share),
      ),
    );
  }

  void _addNote() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Enter title"),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: "Enter content"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notes.add({
                    'title': titleController.text,
                    'content': contentController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editNoteAtIndex(BuildContext context, int index) {
    TextEditingController titleController =
        TextEditingController(text: notes[index]['title'] ?? '');
    TextEditingController contentController =
        TextEditingController(text: notes[index]['content'] ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Edit title"),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: "Edit content"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notes[index]['title'] = titleController.text;
                  notes[index]['content'] = contentController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNoteAtIndex(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _sortNotes() {
    setState(() {
      notes.sort((a, b) => (a['title'] ?? '').compareTo(b['title'] ?? ''));
    });
  }

  void _clearAllNotes() {
    setState(() {
      notes.clear();
    });
  }

  void _shareNotes() {}
}
