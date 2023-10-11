import requests
import xml.etree.ElementTree as ET

# URL
# https://www.w3schools.com/xml/tempconvert.asmx?op=CelsiusToFahrenheit

from base64 import b64encode

def basic_auth(username, password):
    token = b64encode(f"{username}:{password}".encode('utf-8')).decode("ascii")
    return f'Basic {token}'

basic_auth('username', 'pass')


celcius = input("Please input celcius : ")
# celcius = "78"

url = "https://www.w3schools.com/xml/tempconvert.asmx"

## ROOT ELEMENT SOAP MESSAGE
SOAPEnvelope = f"""<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <CelsiusToFahrenheit xmlns="https://www.w3schools.com/xml/">
      <Celsius> {celcius} </Celsius>
    </CelsiusToFahrenheit>
  </soap:Body>
</soap:Envelope>"""

options = {
    "Authentication": basic_auth('username', 'pass'),
    "Content-Type": "text/xml; charset=utf-8"
}

response = requests.post(url, data=SOAPEnvelope, headers=options)

## XML PARSER
root = ET.fromstring(response.text)

# AT ADDRESS
for child in root.iter("*"):
    print(child)

# RESULT TAG AND TEXT
for child in root.iter("*"):
    print(child.tag, child.text)

# FINAL RESULT
for child in root.iter("{https://www.w3schools.com/xml/}CelsiusToFahrenheitResult"):
    C2F = child.text
print(f"RESULT = {C2F} F")
