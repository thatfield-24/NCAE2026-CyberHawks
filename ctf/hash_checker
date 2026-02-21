import hashlib

hash_input = input("Enter hash: ").strip()
wordlist = input("Enter wordlist file: ").strip()

with open(wordlist) as f:
    for word in f:
        word = word.strip()

        if hashlib.md5(word.encode()).hexdigest() == hash_input:
            print("MD5 match:", word)

        if hashlib.sha1(word.encode()).hexdigest() == hash_input:
            print("SHA1 match:", word)

        if hashlib.sha256(word.encode()).hexdigest() == hash_input:
            print("SHA256 match:", word)
