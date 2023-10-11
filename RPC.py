from xmlrpc.server import SimpleXMLRPCServer


# RPC Server

def add(num1, num2):
    return num1 + num2


def mult(num1, num2):
    return num1 * num2


def minus(num1, num2):
    return num1 - num2


def div(num1, num2):
    return num1/num2


server = SimpleXMLRPCServer(('localhost', 6789))
server.register_function(add, "add")
server.register_function(mult, "mult")
server.register_function(minus, "minus")
server.register_function(div, "div")
server.serve_forever()
