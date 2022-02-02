import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final s = await ServerSocket.bind('0.0.0.0', 6969);
  final Set<Socket> sockets = {};

  s.listen((socket) {
    sockets.add(socket);

    socket.listen(
      (v) {
        if (utf8.decode(v).trim().isNotEmpty) {
          for (final s in sockets) {
            s.add(utf8.encode('> ') + v);
          }
        }
      },
    )
      ..onError((_) => sockets.remove(socket))
      ..onDone(() => sockets.remove(socket));
  });
}
