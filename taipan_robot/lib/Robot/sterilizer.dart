import 'dart:async';
import 'dart:io';

class Sterilizer {
  bool isUvOn = false;
  bool isMistOn = false;
  int _uvParam = 2;
  int _mistParam = 4;
  late Socket sock;

  Sterilizer() {
    Socket.connect('192.168.11.32', 5555).then((s) {
      sock = s;
      sync();
    });
  }

  dispose() {
    sock.close();
  }

  void setLight(bool on) {
    isUvOn = on;
    _uvParam = on ? 1 : 2;
  }

  void setMist(bool on) {
    isMistOn = on;
    _mistParam = on ? 3 : 4;
  }

  void sync() {
    Timer.periodic(Duration(seconds: 1), (_) {
      sock.add([0x73, 0x68, _uvParam, 0x23, 0x62]);
      sock.add([0x73, 0x68, _mistParam, 0x23, 0x62]);
    });
  }
}
