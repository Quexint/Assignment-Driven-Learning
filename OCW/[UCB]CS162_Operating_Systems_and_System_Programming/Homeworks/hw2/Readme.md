# HW02 HTTP Server

## Summary

- Support **HTTP server** mode and **Proxy** mode.
- **HTTP Server Mode**: Read an HTTP request from client and response the file to client.
- **Proxy Mode**: A bridge between a website and client, use **select()** to do non-blocking I/O.


## Spec.

1. Create a listening socket and bind it to a port2. Wait a client to connect to the port3. Accept the client and obtain a new connection socket4. Fork a child process to handle the client via the connection socket5. Parent process goes back to accept more connections on the original socket6. Child Process reads in and parses the HTTP request7. Child Process will do **one** of two things: (determined by command line arguments)
	- Serve a file from the local file system, or yield a 404 Not Found
	- Proxy the request to another HTTP serverThe httpserver will be in **either** file mode or proxy mode. It does not do both things at the sametime.8. Child Process sends the appropriate HTTP response header and attached file/document back tothe client (or an error message)


## Commands

- **Environment**: [Vagrantfile](../Vagrantfile)
- **Compile**: `$ make`
- **Execute**
	- **HTTP Server**: `./httpserver --files www_directory/ --port 8000`
	- **Proxy Server**: `./httpserver --proxy inst.eecs.berkeley.edu:80 --port 8000`
- **Access**: `http://192.168.162.162:8000/` (Connect to Vagarant)
