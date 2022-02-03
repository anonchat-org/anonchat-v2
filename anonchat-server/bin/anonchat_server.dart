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
  print('\/\/ Launched server on port ${int.parse(arguments[0])}\n');
  server.listen((socket) {
    // Add fresh connected client to the list
    sockets.add(socket);

    socket.listen(
      (packet) {
        var pack = utf8.decode(packet, allowMalformed: true).trim();
        try {
          // Check if a packet uses the v2 system
          var v2check = json.decode(pack);
          // Broadcast it to all connected cleints
          print(pack);
          for (final s in sockets) {
            s.add(packet);
          }
        } on FormatException catch (e) {
          // In case the packet is using the v1 system (plaintext)
          print('v1 packet recieved: $pack');
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
