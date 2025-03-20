import 'package:flutter/material.dart';
import 'boon_form_screen.dart';
import 'sqlite.dart';
import 'boon_model.dart';
import 'ViewBoonScreen.dart';

class BoonListViewScreen extends StatefulWidget {
  const BoonListViewScreen({super.key});

  @override
  State<BoonListViewScreen> createState() => _BoonListViewScreenState();
}

class _BoonListViewScreenState extends State<BoonListViewScreen> {
  List<BoonModel> _boons = [];

  @override
  void initState() {
    super.initState();
    _loadBoons();
  }

  Future<void> _loadBoons() async {
    final boons = await Sqlitebase.instance.getBoons();
    setState(() {
      _boons = boons;
    });
  }

  Future<void> _deleteBoon(int id) async {
    await Sqlitebase.instance.deleteBoon(id);
    _loadBoons();
  }

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

              if (result != null) {
                _loadBoons();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: _boons.isEmpty
            ? const Center(child: Text('No data available'))
            : ListView.builder(
                itemCount: _boons.length,
                itemBuilder: (context, index) {
                  final boon = _boons[index];
                  return Card(
                    child: ListTile(
                      title: Text(boon.title),
                      subtitle: Text(boon.desc ?? 'No description'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility, color: Colors.blue),
                            onPressed: () {
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewBoonScreen(boon: boon),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () async {
                              
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BoonFormScreen(boon: boon),
                                ),
                              );
                              
                              if (result != null) {
                                _loadBoons();
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteBoon(boon.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
