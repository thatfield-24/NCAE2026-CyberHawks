import subprocess

filename = input("Enter file name: ").strip()

print("\n[*] File type:")
subprocess.run(["file", filename])

print("\n[*] Strings scan:")
subprocess.run(f"strings {filename} | grep -i flag", shell=True)

print("\n[*] Metadata:")
subprocess.run(["exiftool", filename])

print("\n[*] Binwalk scan:")
subprocess.run(["binwalk", filename])

print("\nScan complete.")
