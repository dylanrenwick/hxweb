package hxweb;

import sys.net.Host;
import sys.net.Socket;
import haxe.io.Bytes;
import haxe.io.Eof;
import haxe.io.Error;

class HttpServer {
    private var socket:Socket;
    private var readSockets:Array<Socket>;
    private var buffer:Bytes;
    private var clients:Map<Socket, Connection>;

    public function new() {
        buffer = Bytes.alloc(8192);
        socket = new Socket();
        readSockets = [socket];
        clients = new Map<Socket, Connection>();
    }

    public function start(host:Host, port:Int, maxConns:Int) {
        trace('Listening for connections...');
        socket.bind(host, port);
        socket.listen(maxConns);
        while(true) {
            update();
            Sys.sleep(0.01);
        }
    }

    private function update() {
        var bytesReceived:Int;
        var select = Socket.select(readSockets, null, null, 0);
        for (sckt in select.read) {
            if (sckt == socket) {
                var client = socket.accept();
                var connection = new Connection(client);
                trace('Accepting new connection...');
                readSockets.push(client);
                clients.set(client, connection);
                client.setBlocking(false);
                trace('New connected accepted');
            }
            else {
                //trace('Checking client socket...');
                try {
                    //trace('Checking bytes...');
                    bytesReceived = sckt.input.readBytes(buffer, 0, buffer.length);
                    if (bytesReceived > 0) {
                        trace('Bytes found');
                        trace(parseRequest(buffer.getString(0, buffer.length).split('\n')));
                    }
                    else {
                        //trace('No bytes found');
                    }
                }
                catch (e:Dynamic) {
                    if (e.toString() == "Custom(EOF)") {
                        trace('Eof error ' + e);
                        sckt.close();
                        readSockets.remove(sckt);
                        clients.remove(sckt);
                        trace('Connection closed due to Eof error');
                        continue;
                    }
                }
                if (!clients[sckt].isOpen()) {
                    trace('Socket is closed');
                    readSockets.remove(sckt);
                    clients.remove(sckt);
                }
            }
        }
    }

    private function parseRequest(request:Array<String>):HttpRequest {
        //trace(request[0]);
        var method = request[0].split(' ')[0];
        var path = request[0].split(' ')[1];
        var httpVer = request[0].split(' ')[2];
        //trace(request[1]);
        //var userAgent = request[1].substr(12);
        //trace(request[2]);
        //var host = request[2].substr(6);
        return new HttpRequest(method, path, httpVer);
    }
}
