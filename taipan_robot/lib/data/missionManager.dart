import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mission.dart';

class MissionManager {
  static final MissionManager _missionManager = MissionManager._internal();

  factory MissionManager() {
    return _missionManager;
  }
  MissionManager._internal() {
    initPref().then((sp) {
      prefs = sp;
      getMissions();
      getlastMission();
    });
  }
  late SharedPreferences prefs;
  Mission mission = new Mission('New');
  List<String> missions = [];

  Future<SharedPreferences> initPref() async {
    return SharedPreferences.getInstance();
  }

  void saveMission() {
    String serialized = JsonMapper.serialize(mission);
    print(serialized);
    prefs.setString('@mission_' + mission.name, serialized);
    prefs.setString('currMission', mission.name);
    missions.add(mission.name);
  }

  List<String> getMissions() {
    missions.clear();
    List<String> tmp = prefs
        .getKeys()
        .where((element) => element.startsWith('@mission_'))
        .toList();
    print(prefs.getKeys());
    tmp.forEach((element) {
      missions.add(element.substring(9));
    });
    return missions;
  }

  void getlastMission() {
    String currentMission = prefs.getString('currMission') ?? '';
    if (currentMission.isNotEmpty) {
      print(currentMission);
    }
  }
}
