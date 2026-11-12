import 'package:flutter/material.dart';
import '../models/student.dart';

class EditProfileScreen extends StatefulWidget {
  final Student currentStudent;
  final Function(Student) onSave;

  const EditProfileScreen({
    Key? key,
    required this.currentStudent,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _nimController;
  late TextEditingController _prodiController;
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentStudent.name);
    _nimController = TextEditingController(text: widget.currentStudent.nim);
    _prodiController = TextEditingController(text: widget.currentStudent.programStudi);
    _emailController = TextEditingController(text: widget.currentStudent.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _prodiController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'NIM tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prodiController,
                decoration: const InputDecoration(labelText: 'Program Studi', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Program Studi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Email tidak boleh kosong' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Student updatedStudent = Student(
                      name: _nameController.text,
                      nim: _nimController.text,
                      programStudi: _prodiController.text,
                      email: _emailController.text,
                    );
                    widget.onSave(updatedStudent);
                    Navigator.pop(context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Simpan Perubahan', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}