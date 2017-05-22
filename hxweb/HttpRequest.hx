package hxweb;

class HttpRequest {
    public var method:String;
    public var path:String;
    public var httpVer:String;
    public var userAgent:String;
    public var host:String;

    public function new(method:String, path:String, httpVer:String) {
        this.method = method;
        this.path = path;
        this.httpVer = httpVer;
        //trace("Method: " + method + " | Path: " + path + " | HttpVersion: " + httpVer);
    }

    public function toString():String {
        return "Method: " + method + " | Path: " + path + " | HttpVersion: " + httpVer;
    }
}
