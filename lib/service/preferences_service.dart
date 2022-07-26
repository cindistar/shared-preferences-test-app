import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_app/models/models.dart';

class PreferencesService {
  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('userName', settings.username);
    await preferences.setBool('isEmployed', settings.isEmployed);
    await preferences.setInt('gender', settings.gender.index);
    await preferences.setStringList(
      'programmingLanguages',
      settings.programmingLanguages.map((language) => language.index.toString()).toList(),
    );
    print('Saved settings');
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();

    final userName = preferences.getString('userName');
    final isEmployed = preferences.getBool('isEmployed');
    final gender = Gender.values[preferences.getInt('gender') ?? 0];

    final programmingLanguagesIndices = preferences.getStringList('programmingLanguages');
    final programmingLanguages =
        programmingLanguagesIndices!.map((stringIdex) => ProgrammingLanguages.values[int.parse(stringIdex)]).toSet();

    return Settings(
      username: userName!,
      gender: gender,
      programmingLanguages: programmingLanguages,
      isEmployed: isEmployed!,
    );
  }
}
