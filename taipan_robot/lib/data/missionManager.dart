import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mission.dart';

class MissionManager {
  static final MissionManager _missionManager = MissionManager._internal();

  factory MissionManager() {
    return _missionManager;
  }
  MissionManager._internal();

  Mission mission = new Mission('New');

  void saveMission() async {
    String serialized = JsonMapper.serialize(mission);
    print(serialized);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(mission.name, serialized);
  }
}
