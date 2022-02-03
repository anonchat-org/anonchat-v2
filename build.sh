dart format anonchat-cli/bin/anonchat_cli.dart
dart format anonchat-server/bin/anonchat_server.dart
rm -rf build
mkdir build
dart compile exe anonchat-cli/bin/anonchat_cli.dart -o build/cli
dart compile exe anonchat-server/bin/anonchat_server.dart -o build/server
chmod +x build/*
