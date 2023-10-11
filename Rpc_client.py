import xmlrpc.client 

proxy = xmlrpc.client.ServerProxy('http://localhost:6789/')

num1 = float(input("Please input first number : "))
num2 = float(input("Please input second number : "))
# num1 = 12
# num2 = 13
result = proxy.add(num1,num2)
resultmin = proxy.minus(num1,num2)
resultmult = proxy.mult(num1,num2)
resultdiv = proxy.div(num1,num2)

print(f'Result : {result}')
print(f'Result : {resultmin}')
print(f'Result : {resultmult}')
print(f'Result : {resultdiv}')
