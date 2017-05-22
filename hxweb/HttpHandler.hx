package hxweb;

class HttpHandler implements IHttpHandler {
    public function new() {}

    public function handleRequest(request:HttpRequest):Int {
        trace(request);
        return 200;
    }
}
