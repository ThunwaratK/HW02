import 'package:cp_213_sqflife_thunwarat/boon_model.dart';
import 'package:cp_213_sqflife_thunwarat/sqflite_database.dart';
import 'package:flutter/material.dart';

class BoonFormScreen extends StatefulWidget {
  const BoonFormScreen({super.key});

  @override
  State<BoonFormScreen> createState() => _BoonFormScreenState();
}

class _BoonFormScreenState extends State<BoonFormScreen> {
  final _boonFormKey = GlobalKey<FormState>();
  final SqfliteDatabase _sqfliteDatabase = SqfliteDatabase();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _startHourController = TextEditingController();
  final TextEditingController _startMinuteController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  int? _boonId;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the BoonModel passed as an argument (if any)
    final BoonModel? boon =
        ModalRoute.of(context)?.settings.arguments as BoonModel?;
    if (boon != null) {
      _boonId = boon.id;
      _titleController.text = boon.title;
      _descController.text = boon.desc ?? '';
      _eventDateController.text = boon.eventDate;
      _startHourController.text = boon.startHour;
      _startMinuteController.text = boon.startMinute;
      _locationController.text = boon.location;
    }
  }

  Future<void> _saveBoon() async {
    if (_boonFormKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final desc = _descController.text.trim();
      final eventDate = _eventDateController.text.trim();
      final startHour = _startHourController.text.trim();
      final startMinute = _startMinuteController.text.trim();
      final location = _locationController.text.trim();

      final boon = BoonModel(
        id: _boonId,
        title: title,
        desc: desc,
        eventDate: eventDate,
        startHour: startHour,
        startMinute: startMinute,
        location: location,
      );

      if (_boonId == null) {
        // Insert new boon
        await _sqfliteDatabase.insertBoon(boon);
      }
      Navigator.pop(context, true); // Return true to refresh the list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          _boonId == null ? 'Create Boon' : 'Update Boon',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.grey[400],
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _boonFormKey,
            child: Column(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.25,
                  child: Image.asset('assets/images/tak_bat.png'),
                ),
                const SizedBox(height: 20),
                _buildTextField('Title', 'Enter title', _titleController, true),
                const SizedBox(height: 10),
                _buildTextField(
                  'Description',
                  'Enter description',
                  _descController,
                  false,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'Event Date',
                  'Enter event date: mm/dd/yyyy',
                  _eventDateController,
                  true,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'Start Hour',
                  'Enter start hour: hh',
                  _startHourController,
                  true,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'Start Minute',
                  'Enter start minute: mm',
                  _startMinuteController,
                  true,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'Location',
                  'Enter location',
                  _locationController,
                  true,
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shadowColor: Colors.deepPurple,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: _saveBoon,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shadowColor: Colors.deepPurple,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          _boonFormKey.currentState!.reset();
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
    bool isRequired,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              border: InputBorder.none,
            ),
            validator:
                isRequired
                    ? (value) {
                      if (value == null || value.isEmpty) {
                        return '$label CANNOT be empty.';
                      }
                      return null;
                    }
                    : null,
          ),
        ),
      ),
    );
  }
}
