<div align="center" style="text-align:center">

<h1>AnonChat</h1>
<i>Originally made by Arslee on <a href="https://github.com/arslee07/anonchat">arslee07/anonchat</a>.</i><br><br>
<img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/anonchat-org/anonchat-v2?logo=github">
<img alt="License" src="https://img.shields.io/github/license/anonchat-org/anonchat-v2">
<hr/>
<img src="https://pyt.igorek.dev/images/acpreview.png" width="500px"/>
</div>

## What's this?
**Anonchat is a microprotocol for communication build on Dart using sockets.**

A server acts as a message distributor between the connected clients, while a client can send and recieve messages

A typical v2 message looks like this:

```json
{"user": "calamity", "msg": "hey, how you doing today?"}
```

---
## Building
If you want to build the client and the server, you need to get the **Dart SDK (https://dart.dev/get-dart)** and **git**

For running the server you need to port-forward the port you are going to choose to run the server.

Instructions:
```sh
# 1. Clone the repository
git clone https://github.com/anonchat-org/anonchat-v2.git
cd anonchat-v2

# 2. Get dependencies
dart pub get -C anonchat-cli
dart pub get -C anonchar-server

# 3. Build the executables
#    If you want to build for other platforms - see `dart compile`
#    A build script is provided - `./build.sh`

mkdir build
dart compile exe anonchat-server/bin/anonchat_server.dart -o build/server && chmod +x build/server # for server
dart compile exe anonchat-cli/bin/anonchat_cli.dart -o build/cli && chmod +x build/cli # for cli client
```
The built executables will be in the `build` folder.

---
## Running
After you've downloaded the binaries from the [releases](https://github.com/anonchat-org/anonchat-v2/releases/latest), put them where you need to.

### Client
Usage: `./cli <host>:<port> [nick]`

`host`: an IP address or a domain (eg. 5.68.217.124, github.com) \
`port`: the port that the server is running on (eg. 2345, 25565) \
`nick`: optional - your nickname, can be anything, defaults to Anon (eg. calamity, dave, COD\_gaming\_2005) 

Example: `./cli example.com:2345 bob`
### Server
Usage: `./server <port>`

`port`: the port that the server will be running on, needs to be port-forwarded in router settings. \

On the first run the server will notify you that a `server.json` config file has been created. You can find and edit it in `~/.config/anonchat/server.json`. It features these keys:

```json
"serverName": will be used later, but you can set it now, just in case.
"protocol": will be used later, but **DO NOT CHANGE** the value from v2, as that might cause clients to not connect to your server.
"motdEnable": a toggle for `motd`. false by default, change it to true if you want to.
"motd": abbreviation for "message of the day". a greeting message to people joining the server. off by default, turn on by changing *motdEnable* to true.
```

Running the server executable again should launch it immediately.

Example: `./server 2345`

---

### Feel free to open an issue/PR if you have anything to say/ask!
