<div align="center" style="text-align:center">

<h1>AnonChat</h1>
<i>Originally made by Arslee on <a href="https://github.com/arslee07/anonchat">arslee07/anonchat</a>.</i>
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

# 2. Build the executables
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
Usage: `./server <port> [--motd]`

`port`: the port that the server will be running on, needs to be port-forwarded in router settings. \
`--motd`: optional - this flag is used for displaying a personal message on user join, configured in server file. **currently in beta.** 

---

### Feel free to open an issue/PR if you have anything to say/ask!
