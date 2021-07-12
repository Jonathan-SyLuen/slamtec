import 'dart:io';
import 'dart:convert';

class Sterlizer {
  void onLight() async {
    Socket socket = await Socket.connect('192.168.11.32', 5555);

    print('connected');
    socket.add([0x73, 0x68, 0x01, 0x23, 0x62]);

    socket.close();
  }

  void offLight() async {
    Socket socket = await Socket.connect('192.168.11.32', 5555);

    print('connected');
    socket.add([0x73, 0x68, 0x02, 0x23, 0x62]);

    socket.close();
  }

  void onMist() async {
    Socket socket = await Socket.connect('192.168.11.32', 5555);

    print('connected');
    socket.add([0x73, 0x68, 0x03, 0x23, 0x62]);

    socket.close();
  }

  void offMist() async {
    Socket socket = await Socket.connect('192.168.11.32', 5555);

    print('connected');
    socket.add([0x73, 0x68, 0x04, 0x23, 0x62]);

    socket.close();
  }
}
