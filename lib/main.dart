import 'package:flutter/material.dart';
import 'providers/app_provider.dart';
import 'models/student.dart';
import 'models/note.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Data Awal Mahasiswa
  Student _student = Student(
    name: 'Muhammad Hafidh Arkan Ramadhan',
    nim: '25.11.6585',
    programStudi: 'S1 Informatika',
    email: 'hafidh@email.com',
  );

  // List Catatan Awal
  final List<Note> _notes = [
    Note(
      id: '1',
      title: 'Tugas Pemrograman Mobile - Selesai',
      date: DateTime.now(),
    ),
    Note(
      id: '2',
      title: 'Praktikum Jaringan Komputer - Packet Tracer 100%',
      date: DateTime.now(),
    ),
  ];

  void _updateStudent(Student updatedStudent) {
    setState(() {
      _student = updatedStudent;
    });
  }

  void _addNote(Note newNote) {
    setState(() {
      _notes.add(newNote);
    });
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      student: _student,
      notes: _notes,
      updateStudent: _updateStudent,
      addNote: _addNote,
      deleteNote: _deleteNote,
      child: MaterialApp(
        title: 'Profil & Catatan Mahasiswa',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false, // Menghilangkan tulisan DEBUG
        home: const HomeScreen(),
      ),
    );
  }
}