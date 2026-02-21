# XOR brute force cracker

def xor_decrypt(data_bytes, key):
    # XOR each byte with the key
    return bytes([b ^ key for b in data_bytes])


def is_readable(text):
    # Check if output looks like readable ASCII
    return all(32 <= c < 127 or c in (9, 10, 13) for c in text)


# Get hex input from user
hex_input = input("Enter hex string: ").strip()

# Convert hex to bytes
try:
    data = bytes.fromhex(hex_input)
except ValueError:
    print("Invalid hex input")
    exit()

print("\n--- Possible decryptions ---\n")

# Try all 256 single-byte XOR keys
for key in range(256):
    result = xor_decrypt(data, key)

    if is_readable(result):
        decoded = result.decode(errors="ignore")
        print(f"Key {key:3}: {decoded}")

        # Highlight likely flags
        if "flag" in decoded.lower() or "ctf" in decoded.lower() or "{" in decoded:
            print("  >>> POSSIBLE FLAG <<<")
