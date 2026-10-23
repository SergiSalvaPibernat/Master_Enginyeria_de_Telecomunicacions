package apiREST;

public interface Comms {
    String PATH = "localhost:8080/uppercaseServer";
    String SERVER_REST = "http://"+PATH+"/webresources";
    String SERVER_WEBSOCKET = "ws://"+PATH+"/ws";
}
