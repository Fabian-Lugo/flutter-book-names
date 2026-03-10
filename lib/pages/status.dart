import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_name/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    /* socketService.socket.emit(event); */

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('ServerStatus: ${socketService.serverStatus.name}'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Tarea
          //Emitir: emitir-mensaje
          // {nombre: 'Flutter', mensaje: 'Hola desde flutter'}
          if (socketService.serverStatus == ServerStatus.online) {
            socketService.socket.emit('emitir-mensaje', {
              'nombre': 'Flutter',
              'mensaje': 'Hola desde flutter',
            });
            debugPrint('Enviado a node');
          } else {
            debugPrint('Error server Offline');
          }
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
