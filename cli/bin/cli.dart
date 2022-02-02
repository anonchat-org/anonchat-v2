import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final socket = await Socket.connect('127.0.0.1', 6969);
  stdin.listen(socket.add);
  socket.listen((v) => print(utf8.decode(v).trim()));
}
