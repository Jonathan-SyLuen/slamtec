import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mission.dart';

class MissionManager {
  static final MissionManager _missionManager = MissionManager._internal();
  late SharedPreferences prefs;
  factory MissionManager() {
    return _missionManager;
  }
  MissionManager._internal() {
    SharedPreferences.getInstance().then((sp) {
      prefs = sp;
      getMissions();
    });
  }

  List<Mission> missions = [];
  int _activeMission = 0;

  int get activeMission {
    return _activeMission;
  }

  set activeMission(int index) {
    if (index < missions.length) {
      _activeMission = index;
      prefs.setInt('activeMission', index);
    }
  }

  void saveMission() {
    String serialized = JsonMapper.serialize(missions[activeMission]);
    prefs.setString('mission_$activeMission', serialized);
  }

  void getMissions() {
    for (int i = 0; i < 4; i++) {
      print('Mission $i');
      String str = prefs.getString('mission_$i') ?? '';
      if (str.isEmpty) {
        Mission x = new Mission('Empty mission');
        str = JsonMapper.serialize(x);
        missions.add(x);
      } else {
        Mission x =
            JsonMapper.deserialize<Mission>(str) ?? new Mission('failed');
        missions.add(x);
      }
      //missions.add(JsonMapper.deserialize<Mission>(str)!);
    }
    _activeMission = prefs.getInt('activeMission') ?? 0;
  }
}
