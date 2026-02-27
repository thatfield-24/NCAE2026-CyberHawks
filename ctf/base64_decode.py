import base64
import sys

def decode_base64(text):
    try:
        decoded = base64.b64decode(text).decode("utf-8", errors="ignore")
        print("\nDecoded text:\n")
        print(decoded)
    except Exception:
        print("Invalid Base64 input.")

# Input from file or paste
if len(sys.argv) > 1:
    try:
        with open(sys.argv[1], "r", encoding="utf-8", errors="ignore") as f:
            text = f.read().strip()
    except FileNotFoundError:
        print("File not found.")
        sys.exit(1)
else:
    text = input("Paste Base64 text: ").strip()

decode_base64(text)
