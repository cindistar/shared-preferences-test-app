enum Gender { female, male, other }

enum ProgrammingLanguages { dart, python, java, kotlin }

class Settings {
  final String username;
  final Gender gender;
  final Set<ProgrammingLanguages> programmingLanguages;
  final bool isEmployed;

  Settings({
    required this.username,
    required this.gender,
    required this.programmingLanguages,
    required this.isEmployed,
  });
}
