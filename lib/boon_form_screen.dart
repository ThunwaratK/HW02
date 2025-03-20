import 'package:flutter/material.dart';
import 'boon_model.dart';
import 'sqlite.dart';

class BoonFormScreen extends StatefulWidget {
  final BoonModel? boon;
  final Function()? onSave;

  const BoonFormScreen({super.key, this.boon, this.onSave});

  @override
  State<BoonFormScreen> createState() => _BoonFormScreenState();
}

class _BoonFormScreenState extends State<BoonFormScreen> {
  final _boonFormKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _startHourController = TextEditingController();
  final TextEditingController _startMinuteController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.boon != null) {
      _titleController.text = widget.boon!.title;
      _descController.text = widget.boon!.desc ?? '';
      _eventDateController.text = widget.boon!.eventDate;
      _startHourController.text = widget.boon!.startHour;
      _startMinuteController.text = widget.boon!.startMinute;
      _locationController.text = widget.boon!.location;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _eventDateController.dispose();
    _startHourController.dispose();
    _startMinuteController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _saveBoon() async {
    if (_boonFormKey.currentState!.validate()) {
      final boon = BoonModel(
        id: widget.boon?.id,  
        title: _titleController.text.trim(),
        desc: _descController.text.trim(),
        eventDate: _eventDateController.text.trim(),
        startHour: _startHourController.text.trim(),
        startMinute: _startMinuteController.text.trim(),
        location: _locationController.text.trim(),
      );

      if (boon.id == null) {
        await Sqlitebase.instance.insertBoon(boon);
      } else {
        await Sqlitebase.instance.updateBoon(boon);
      }

      if (mounted) {
        if (widget.onSave != null) {
          widget.onSave!();
        }
        Navigator.pop(context, true); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create/Edit Boon'),
        backgroundColor: Colors.grey[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _boonFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _eventDateController,
                decoration: const InputDecoration(labelText: 'Event Date'),
              ),
              TextFormField(
                controller: _startHourController,
                decoration: const InputDecoration(labelText: 'Start Hour'),
              ),
              TextFormField(
                controller: _startMinuteController,
                decoration: const InputDecoration(labelText: 'Start Minute'),
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveBoon,
                child: Text(widget.boon == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
