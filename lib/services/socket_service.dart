import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => this._socket!;


  SocketService() {
    this.initConfig();
  }

  void initConfig() {
    this._socket = IO.io(
      'https://book-names-server.onrender.com',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .enableAutoConnect()
          .build(),
    );

    this._socket!.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    this._socket!.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    /* socket.on('nuevo-mensaje', (payload) {
      if (payload == null) return;

      final nombre = (payload['nombre'] ?? 'sin nombre').toString();
      final edad = (payload['edad'] ?? 'sin edad').toString();
      debugPrint('nombre: $nombre');
      debugPrint('edad: $edad');
      if (payload.containsKey('mensaje') && payload['mensaje'] != null) {
        debugPrint('mensaje ${payload['mensaje']}');
      } else {
        debugPrint('mensaje: no hay');
      }
    }); */
  }
}
