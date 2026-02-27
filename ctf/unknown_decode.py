import base64
import urllib.parse

text = input("Enter encoded string: ").strip()

print("\n--- TRYING DECODES ---\n")

# Base64
try:
    print("Base64:", base64.b64decode(text).decode())
except:
    print("Base64 failed")

# Hex
try:
    print("Hex:", bytes.fromhex(text).decode())
except:
    print("Hex failed")

# URL encoding
try:
    decoded = urllib.parse.unquote(text)
    if decoded != text:
        print("URL decoded:", decoded)
except:
    pass

# ROT shifts
import string

def rot(s, n):
    lower = string.ascii_lowercase
    upper = string.ascii_uppercase
    trans = str.maketrans(
        lower + upper,
        lower[n:] + lower[:n] + upper[n:] + upper[:n]
    )
    return s.translate(trans)

print("\nROT shifts:")
for i in range(1, 26):
    r = rot(text, i)
    if any(x in r.lower() for x in ["flag", "{", "ctf"]):
        print(f"ROT{i}: {r}  <<< POSSIBLE FLAG")
