package hxweb;

import sys.net.Socket;
import haxe.io.Bytes;

class Connection {
    private var socket:Socket;

    public function new(socket:Socket) {
        this.socket = socket;
    }

    public function isOpen():Bool {
        return socket != null;
    }

    public function writeBytes(bytes:Bytes):Bool {
        try {
            socket.output.writeBytes(bytes, 0, bytes.length);
        }
        catch (e:Dynamic) {
            return false;
        }
        return true;
    }

    public function close() {
        socket.close();
        socket = null;
    }
}
