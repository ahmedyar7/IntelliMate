import 'package:hive/hive.dart';

part 'settings.g.dart';

/**
 * This file would allow the ai agent to speak and
 * allow it to interact with the user itself
 *
*/

@HiveType(typeId: 2)
class Settings extends HiveObject {
  @HiveField(0)
  bool isDarkTheme = false;

  @HiveField(1)
  bool shouldSpeak = false;

  // Constructor
  Settings({required this.isDarkTheme, required this.shouldSpeak});
}
