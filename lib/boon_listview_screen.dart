import 'package:cp_213_sqflife_thunwarat/boon_model.dart';
import 'package:cp_213_sqflife_thunwarat/sqflite_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'boon_form_screen.dart';

class BoonListViewScreen extends StatefulWidget {
  const BoonListViewScreen({super.key});

  @override
  State<BoonListViewScreen> createState() => _BoonListViewScreenState();
}

class _BoonListViewScreenState extends State<BoonListViewScreen> {
  final SqfliteDatabase _sqfliteDatabase = SqfliteDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Boon ListView',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[400],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BoonFormScreen()),
              );
              if (result == true) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<List<BoonModel>>(
          stream: _sqfliteDatabase.getBoonListStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            final boonList = snapshot.data!;

            return ListView.separated(
              itemBuilder: (context, index) {
                final boon = boonList[index];
                return Card(
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple[200],
                      child: const Icon(Icons.place),
                    ),
                    title: Text(
                      boon.title,
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${boon.location} - ${boon.eventDate}',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigate to edit screen (not implemented here)
                          },
                          icon: const Icon(Icons.edit, color: Colors.orange),
                        ),
                        IconButton(
                          onPressed: () {
                            _sqfliteDatabase.deleteBoon(boon.id!);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: boonList.length,
            );
          },
        ),
      ),
    );
  }
}
