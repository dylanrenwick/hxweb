package hxweb;

class HttpResponseFactory {
    public static function Construct(httpVer:String, code:Int, content:String):String {
        var response:String = httpVer + " ";
        var codeName:String = code.toString();
        switch(code) {
            case 200: codeName += " OK";
            case 400: codeName += " Bad Request";
            case 403: codeName += " Forbidden";
            case 404: codeName += " Not Found";
        }
        response += codeName + "\n";
        response += "Date: ";
        var now:Date = Date.now();
        switch(now.getDay()) {
            case 0: response += "Sun, ";
            case 1: response += "Mon, ";
            case 2: response += "Tue, ";
            case 3: response += "Wed, ";
            case 4: response += "Thu, ";
            case 5: response += "Fri, ";
            case 6: response += "Sat, ";
        }
        response += now.getDate() + " ";
        switch(now.getMonth()) {
            case 0:  response += "Jan ";
            case 1:  response += "Feb ";
            case 2:  response += "Mar ";
            case 3:  response += "Apr ";
            case 4:  response += "May ";
            case 5:  response += "Jun ";
            case 6:  response += "Jul ";
            case 7:  response += "Aug ";
            case 8:  response += "Sep ";
            case 9:  response += "Oct ";
            case 10: response += "Nov ";
            case 11: response += "Dec ";
        }
        response += now.getFullYear() + " ";
        response += now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();
        response += " GMT" + "\n";
        response += "Server: hxweb/0.0.1" + "\n";
        response += "Connection: Closed" + "\n";
        if (content.length > 0) {
            response += "Content-Length: " + content.length + "\n";
            response += "Content-Type: text/html" + "\n";
            response += "\n";
            response += content;
        }
    }
}
