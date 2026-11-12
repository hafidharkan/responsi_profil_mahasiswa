import 'package:flutter/material.dart';
import '../providers/app_provider.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = AppProvider.of(context)!;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Mahasiswa')),
      body: Column(
        children: [
          ProfileCard(student: provider.student),
          ElevatedButton(
            onPressed: () {
              // Simulasi Edit Profil
              provider.updateStudent(
                provider.student..name = "${provider.student.name} (Updated)"
              );
            },
            child: const Text('Edit Profil'),
          ),
        ],
      ),
    );
  }
}