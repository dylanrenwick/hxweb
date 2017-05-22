package hxweb;

import sys.net.Socket;
import sys.net.Host;
import haxe.io.Input;
import haxe.io.Eof;
 
class Main {
    public static function main() {
        var httpServ = new HttpServer(new HttpHandler());
        httpServ.start(new Host('127.0.0.1'), 80, 1);
    }
}
