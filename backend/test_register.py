import requests

url = "http://127.0.0.1:5000/register"
data = {
    "username": "aldric",
    "email": "aldric@example.com",
    "password": "mypassword123"
}

response = requests.post(url, json=data)

print(response.json())
