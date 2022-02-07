import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: anonchat-cli <host:port> [username]');
    return;
  }

  // Assign variables
  var socket; // goddamn
  var host = arguments[0].split(':')[0];
  int port = int.parse(arguments[0].split(':')[1]);
  var user;
  if (arguments.length <= 1) {
    user = 'Anon';
  } else {
    user = arguments[1];
  }

  // Connect to the server
  try {
    socket = await Socket.connect(host, port);
    print('\/\/ Connected to $host at $port as $user\n');
  } on SocketException catch (e) {
    print(
        'Couldn\'t connect with the specified host:port combination. Aborting.');
    exit(1);
  }

  // Construct a request and send it
  var req = new Map();
  req['user'] = user;
  stdin.listen((v) {
    req['msg'] = utf8.decode(v).trim();
    socket.add(utf8.encode(jsonEncode(req)));
  });

  // Print new messages
  socket.listen((v) {
    try {
      var recv =
          jsonDecode(utf8.decode(v, allowMalformed: true).trim()); // lgtm
      print('<${recv["user"]}> ' + recv["msg"]);
    } on FormatException catch (e) {
      print('<v1 message> ' + utf8.decode(v, allowMalformed: true).trim());
    }
  });
}
