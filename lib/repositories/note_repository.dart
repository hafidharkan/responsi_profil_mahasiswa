import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';
import '../services/secure_storage_service.dart';

/// Repository untuk mengelola metadata catatan.
class NoteRepository {
  final SecureStorageService _secureStorage = SecureStorageService();
  static const String _metadataKey = 'notes_metadata';

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesJson = prefs.getString(_metadataKey);
    if (notesJson == null) return [];
    
    List<dynamic> decoded = json.decode(notesJson);
    return decoded.map((json) => Note.fromJson(json)).toList();
  }

  Future<void> addNote(Note note, String content) async {
    final notes = await getNotes();
    notes.add(note);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_metadataKey, json.encode(notes.map((e) => e.toJson()).toList()));
    
    // Simpan isi secara aman
    await _secureStorage.saveContent(note.id, content);
  }

  Future<void> deleteNote(String noteId) async {
    final notes = await getNotes();
    notes.removeWhere((note) => note.id == noteId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_metadataKey, json.encode(notes.map((e) => e.toJson()).toList()));
    
    // Hapus isi dari secure storage
    await _secureStorage.deleteContent(noteId);
  }
}