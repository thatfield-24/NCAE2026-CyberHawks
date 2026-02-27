binary = input("Enter binary string: ").strip()

try:
    words = binary.split()
    decoded = "".join(chr(int(b, 2)) for b in words)
    print("Decoded:", decoded)
except:
    print("Invalid binary format")
