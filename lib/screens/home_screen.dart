import 'package:flutter/material.dart';
import '../providers/app_provider.dart';
import '../models/note.dart';
import 'edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = AppProvider.of(context);
    final student = provider!.student;
    final notes = provider.notes;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      child: Text('M', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text('NIM: ${student.nim}'),
                          const SizedBox(height: 2),
                          Text(student.programStudi),
                          const SizedBox(height: 2),
                          Text(student.email, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil Mahasiswa'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        currentStudent: student,
                        onSave: (updatedStudent) {
                          provider.updateStudent(updatedStudent);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 30),

            const Text(
              'Daftar Catatan Kuliah:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            Expanded(
              child: notes.isEmpty
                  ? const Center(child: Text('Belum ada catatan.'))
                  : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(notes[index].title),
                            subtitle: Text(notes[index].date.toLocal().toString().split(' ')[0]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return AlertDialog(
                                      title: const Text('Hapus Catatan'),
                                      content: const Text('Yakin ingin menghapus catatan ini?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(dialogContext),
                                          child: const Text('Batal'),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          onPressed: () {
                                            provider.deleteNote(index);
                                            setState(() {});
                                            Navigator.pop(dialogContext);
                                          },
                                          child: const Text('Hapus', style: TextStyle(color: Colors.white)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text('Tambah Catatan Baru'),
                content: TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(hintText: 'Tulis judul catatan...'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_noteController.text.isNotEmpty) {
                        Note newNote = Note(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _noteController.text,
                          date: DateTime.now(),
                        );
                        provider.addNote(newNote);
                        _noteController.clear();
                        Navigator.pop(dialogContext);
                        setState(() {});
                      }
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}