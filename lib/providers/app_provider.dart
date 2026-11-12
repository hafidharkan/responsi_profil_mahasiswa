import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/note.dart';
import '../repositories/note_repository.dart';


class AppProvider extends InheritedWidget {
  final Student student;
  final List<Note> notes;
  final Function(Student) updateStudent;
  final Function(Note, String) addNote;
  final Function(String) deleteNote;

  const AppProvider({
    Key? key,
    required this.student,
    required this.notes,
    required this.updateStudent,
    required this.addNote,
    required this.deleteNote,
    required Widget child,
  }) : super(key: key, child: child);

  static AppProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>();
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) {
    return student != oldWidget.student || notes != oldWidget.notes;
  }
}

class AppProviderWrapper extends StatefulWidget {
  final Widget child;
  const AppProviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _AppProviderWrapperState createState() => _AppProviderWrapperState();
}

class _AppProviderWrapperState extends State<AppProviderWrapper> {
  final NoteRepository _repo = NoteRepository();
  
  Student _student = Student(
    name: 'Muhammad Hafidh Arkan Ramadhan', 
    nim: '25.11.6585', 
    programStudi: 'S1 Informatika', 
    email: 'm.hafidh@students.amikom.ac.id'
  );
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    final notes = await _repo.getNotes();
    setState(() => _notes = notes);
  }

  void _updateStudent(Student newStudent) {
    setState(() => _student = newStudent);
  }

  void _addNote(Note note, String content) async {
    await _repo.addNote(note, content);
    _loadNotes();
  }

  void _deleteNote(String id) async {
    await _repo.deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      student: _student,
      notes: _notes,
      updateStudent: _updateStudent,
      addNote: _addNote,
      deleteNote: _deleteNote,
      child: widget.child,
    );
  }
}