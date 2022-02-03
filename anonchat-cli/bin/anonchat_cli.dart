import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: anonchat-cli <host:port> [username]');
    return;
  }

  // Assign variables
  String ip = arguments[0].split(':')[0];
  int port = int.parse(arguments[0].split(':')[1]);
  String user;
  if (arguments.length <= 1) {
    user = 'Anon';
  } else {
    user = arguments[1];
  }

  // Connect to the server
  final socket = await Socket.connect(ip, port);
  print('\/\/ Connected to $ip at $port as $user\n');

  // Send message from input
  stdin.listen((v) => socket.add(utf8.encode('<$user> ') + v));

  // Print new messages
  socket.listen(
    (v) => print(utf8.decode(v, allowMalformed: true).trim()),
  );
}
