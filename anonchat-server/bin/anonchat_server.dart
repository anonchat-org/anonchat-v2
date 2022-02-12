import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:pretty_json/pretty_json.dart';

// Initialize config
Future<Map> confinit() async {
  Map<String, String> env = Platform.environment; // GOD WHYYYYY
  // A little workaround to get the full path to config file.
  // Works only on Unix now, will implement Win64/Darwin support later.
  // Unix:    ~/.config/anonchat/server.json
  // Darwin:  ~/Library/Application Support/anonchat/server.json
  // Windows: %appdata%\anonchat\server.json
  var confpath = '/home/${env["USER"]}/.config/anonchat/server.json';
  if (File(confpath).existsSync()) {
    var config = await File(confpath).readAsString();
    return json.decode(config);
  } else {
    print('// No config file detected, creating one ...');
    new File(confpath).createSync(recursive: true);
    // Default values, pretty damn comfortable
    var defconf = new Map();
    defconf['serverName'] = 'Server';
    defconf['protocol'] = 'v2';
    defconf['motdEnable'] = false;
    defconf['motd'] = '\n// Welcome to the Server!\n';
    var config = File(confpath);
    var sink = config.openWrite();
    // Uses the pretty_json package to not push it all as a single string
    sink.write(prettyJson(defconf, indent: 2));
    await sink.flush();
    await sink.close();
    // Anti-monkey(tm) system (patented by me, Calamity34)
    print('// Config created, edit $confpath, then run the server again.');
    exit(1);
  }
}

// The main program
Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) {
    var filename = Platform.script.toFilePath().split('/').last; // wtf
    print('Usage: $filename <port>');
    return;
  }

  // Call the function
  var config = await confinit();

  // All connected sockets
  final Set<Socket> sockets = {};

  // TCP server itself
  final server = await ServerSocket.bind('0.0.0.0', int.parse(arguments[0]));
  print('// Launched server on port ${int.parse(arguments[0])}\n');
  server.listen((socket) {
    // Add fresh connected client to the list
    sockets.add(socket);
    // Send MOTD
    if (config['motdEnable']) {
      var MOTD = new Map();
      MOTD['user'] = '[SERVER]';
      MOTD['msg'] = config['motd'];
      socket.add(utf8.encode(json.encode(MOTD)));
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
      ..onError((_) {
        socket.close();
        sockets.remove(socket);
      })
      ..onDone(() {
        socket.close();
        sockets.remove(socket);
      });
  });
}
