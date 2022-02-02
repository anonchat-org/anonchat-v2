import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final socket = await Socket.connect(
    arguments[0].split(':')[0],
    int.parse(arguments[0].split(':')[1]),
  );

  // Send message from input
  stdin.pipe(socket);

  // Print new messages
  socket.listen(
    (v) => print('> ' + utf8.decode(v, allowMalformed: true).trim()),
  );
}
