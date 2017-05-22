package hxweb;

interface IHttpHandler {
    public function handleRequest(request:HttpRequest):Int;
}
