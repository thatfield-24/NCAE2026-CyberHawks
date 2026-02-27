import sys

def decode_hex(text):
    try:
        decoded = bytes.fromhex(text).decode("utf-8", errors="ignore")
        print("\nDecoded text:\n")
        print(decoded)
    except ValueError:
        print("Invalid hex input.")

# Input from file or paste
if len(sys.argv) > 1:
    try:
        with open(sys.argv[1], "r", encoding="utf-8", errors="ignore") as f:
            text = f.read().strip()
    except FileNotFoundError:
        print("File not found.")
        sys.exit(1)
else:
    text = input("Paste hex string: ").strip()

decode_hex(text)
