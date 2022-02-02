import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: anonchat-bot <host:port>');
    return;
  }

  // Connect to the server
  final socket = await Socket.connect(
    arguments[0].split(':')[0],
    int.parse(arguments[0].split(':')[1]),
  );

  // Bind some commands
  socket.asBroadcastStream().map(utf8.decode)
    ..where((m) => m.startsWith('!ping')).listen((msg) {
      socket.add(utf8.encode('Pong!'));
    })
    ..where((m) => m.startsWith('!echo')).listen((msg) {
      final text = msg.split(' ').sublist(1).join(' ');
      socket.add(utf8.encode(text));
    });
}
