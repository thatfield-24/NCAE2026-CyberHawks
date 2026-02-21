#input from file, run: python3 rotation_cyper.py ciphertext.txt

#input from pasted string, run: python3 rotation_cypher.py
#Paste ciphertext: (enter cypher text here)

import string
import sys

#rotate letters by a shift
def rot_shift(text, shift):
    lower = string.ascii_lowercase
    upper = string.ascii_uppercase
    trans = str.maketrans(
        lower + upper,
        lower[shift:] + lower[:shift] +
        upper[shift:] + upper[:shift]
    )
    return text.translate(trans)

#brute-force all ROT shifts and highlight possible flags
def brute_rot(text):
    for shift in range(1, 26):
        result = rot_shift(text, shift)
        if any(x in result.lower() for x in ["flag", "ctf", "{", "}"]):
            print(f"\n Possible flag at ROT{shift}:")
            print(result)
        else:
            print(f"[ROT{shift}] {result}")

#running different input types
if len(sys.argv) > 1:
    try:
        with open(sys.argv[1], "r", encoding="utf-8", errors="ignore") as f:
            text = f.read()
    except FileNotFoundError:
        print("File not found.")
        sys.exit(1)
else:
    text = input("Paste ciphertext: ")

# Run brute-force
brute_rot(text)
