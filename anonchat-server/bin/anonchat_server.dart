import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) {
    var filename = Platform.script.toFilePath().split('/').last; // wtf
    print('Usage: $filename <port> [--motd]');
    return;
  }

  /// All connected sockets
  final Set<Socket> sockets = {};

  /// TCP server itself
  final server = await ServerSocket.bind('0.0.0.0', int.parse(arguments[0]));
  print('// Launched server on port ${int.parse(arguments[0])}\n');
  server.listen((socket) {
    // Add fresh connected client to the list
    sockets.add(socket);
    // Send MOTD
    for (final m in arguments) {
      if (m == '--motd') {
        var MOTD = new Map();
        MOTD['user'] = '[SERVER]';
        MOTD['msg'] = '\n// Welcome to the server!\n';
        socket.add(utf8.encode(json.encode(MOTD)));
      }
    }

    socket.listen(
      (packet) {
        var pack = utf8.decode(packet, allowMalformed: true).trim();
        try {
          // Check if message is empty
          var recv = json.decode(pack);
          if (recv['msg'] == '') {
          } else {
            // Broadcast it to all connected cleints
            print(pack);
            for (final s in sockets) {
              s.add(packet);
            }
          }
        } on FormatException catch (e) {
          // In case the packet is using the v1 system (plaintext)
          print('v1 packet: $pack');
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
