import 'package:flutter/material.dart';
import 'package:shared_preferences_app/models/models.dart';
import 'package:shared_preferences_app/service/preferences_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _preferencesService = PreferencesService();

  final _nameController = TextEditingController();
  var _selectedGender = Gender.female;
  var _selectedProgrammingLanguages = <ProgrammingLanguages>{};
  bool _isEmployed = false;

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    setState(() {
      _nameController.text = settings.username;
      _selectedGender = settings.gender;
      _selectedProgrammingLanguages = settings.programmingLanguages;
      _isEmployed = settings.isEmployed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shared Preferences'),
      ),
      body: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return ListView(
            children: [
              const SizedBox(height: 30),
              ListTile(
                title: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
              ),
              RadioListTile(
                title: const Text('Female'),
                value: Gender.female,
                groupValue: _selectedGender,
                onChanged: (newValue) => setState(() => _selectedGender = newValue as Gender),
              ),
              RadioListTile(
                title: const Text('Male'),
                value: Gender.male,
                groupValue: _selectedGender,
                onChanged: (newValue) => setState(() => _selectedGender = newValue as Gender),
              ),
              RadioListTile(
                title: const Text('Other'),
                value: Gender.other,
                groupValue: _selectedGender,
                onChanged: (newValue) => setState(() => _selectedGender = newValue as Gender),
              ),
              CheckboxListTile(
                title: const Text('Dart'),
                value: _selectedProgrammingLanguages.contains(ProgrammingLanguages.dart),
                onChanged: (_) {
                  setState(() {
                    _selectedProgrammingLanguages.contains(ProgrammingLanguages.dart)
                        ? _selectedProgrammingLanguages.remove(ProgrammingLanguages.dart)
                        : _selectedProgrammingLanguages.add(ProgrammingLanguages.dart);
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Python'),
                value: _selectedProgrammingLanguages.contains(ProgrammingLanguages.python),
                onChanged: (_) {
                  setState(() {
                    _selectedProgrammingLanguages.contains(ProgrammingLanguages.python)
                        ? _selectedProgrammingLanguages.remove(ProgrammingLanguages.python)
                        : _selectedProgrammingLanguages.add(ProgrammingLanguages.python);
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Java'),
                value: _selectedProgrammingLanguages.contains(ProgrammingLanguages.java),
                onChanged: (_) {
                  setState(() {
                    _selectedProgrammingLanguages.contains(ProgrammingLanguages.java)
                        ? _selectedProgrammingLanguages.remove(ProgrammingLanguages.java)
                        : _selectedProgrammingLanguages.add(ProgrammingLanguages.java);
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Kotlin'),
                value: _selectedProgrammingLanguages.contains(ProgrammingLanguages.kotlin),
                onChanged: (_) {
                  setState(() {
                    _selectedProgrammingLanguages.contains(ProgrammingLanguages.kotlin)
                        ? _selectedProgrammingLanguages.remove(ProgrammingLanguages.kotlin)
                        : _selectedProgrammingLanguages.add(ProgrammingLanguages.kotlin);
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Is Employed'),
                value: _isEmployed,
                onChanged: (newValue) => setState(() => _isEmployed = newValue),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: ElevatedButton(
                  onPressed: _saveSettings,
                  child: const Text('Save',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _saveSettings() {
    final newSettings = Settings(
      username: _nameController.text,
      gender: _selectedGender,
      programmingLanguages: _selectedProgrammingLanguages,
      isEmployed: _isEmployed,
    );
    print(newSettings);
    _preferencesService.saveSettings(newSettings);
  }
}
