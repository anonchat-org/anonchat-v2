import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: anonchat-server <port>');
    return;
  }

  /// All connected sockets
  final Set<Socket> sockets = {};

  /// TCP server itself
  final server = await ServerSocket.bind('0.0.0.0', int.parse(arguments[0]));

  server.listen((socket) {
    // Add fresh connected client to the list
    sockets.add(socket);

    socket.listen(
      (packet) {
        // If the message packet is not empty...
        if (utf8.decode(packet, allowMalformed: true).trim().isNotEmpty) {
          // ...then broadcast it to all connected cleints
          for (final s in sockets) {
            s.add(packet);
          }
        }
      },
    )
      // Remove the socket from the list on disconnect or error
      ..onError((_) => sockets.remove(socket))
      ..onDone(() => sockets.remove(socket));
  });
}
