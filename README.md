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
Let's say you need to connect to a server, which has an ip of `example.com` and port of `2345`.

Example: `./cli example.com:2345`

By default this is going to give you the nickname of Anon, but if you need to identify yourself - you can add a parameter of a nickname

Example: `./cli example.com:2345 bob`
### Server
And let's say that you need to start a server.

First, you need to port-forward the port you are going to run your server on. If you don't know how to do that: [tutorial](https://is.gd/EkKnW1)

Run the server instance with something like `./server 2345`, replacing 6969 with whatever port you wanna run the server on.

You can also pass the `--motd` argument to the server, then it will send the MOTD message from the server config to anyone who joins the server. Like this: `./server 2345 --motd`

---

### Feel free to open an issue/PR if you have anything to say/ask!
