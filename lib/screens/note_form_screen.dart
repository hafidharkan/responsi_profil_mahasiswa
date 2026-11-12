import 'package:flutter/material.dart';
import '../models/note.dart';
import '../providers/app_provider.dart';
import '../utils/validators.dart';

class NoteFormScreen extends StatefulWidget {
  @override
  _NoteFormScreenState createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Judul Catatan'),
                validator: Validators.validateTitle,
                onSaved: (val) => _title = Validators.sanitize(val!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Isi Catatan'),
                validator: Validators.validateContent,
                maxLines: 5,
                onSaved: (val) => _content = Validators.sanitize(val!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newNote = Note(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: _title,
                      date: DateTime.now(),
                    );
                    AppProvider.of(context)!.addNote(newNote, _content);
                    Navigator.pop(context, true);
                  }
                },
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}