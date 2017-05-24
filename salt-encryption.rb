require 'openssl'
require 'digest/sha1'
require "base64"

class BaseEncryptionHandler

	def write_key_to_file(key)
		# Appends to the file. if the file doesnt exist, makes a new one.
		file = File.open(File.join(ENV['HOME'], ".store_keys.txt"), 'a+')
		file.write(key + "\n")
	end

	# Todo -> Need way to read from file, and get key to use to decrypt.
	def read_key_from_file
	end

	def encrypt(str)
		# Create a new cipher object to encrypt with.
		cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
		cipher.encrypt

		chars = ("ai".."z").to_a + ("A".."Z").to_a + (0..64).to_a
		key = OpenSSL::Digest::SHA256.new.digest(chars.sample(8).join(",").gsub(",",""))
		iv = cipher.random_iv

		# load crypto key and iv into the cipher
		cipher.key = key
		cipher.iv = iv

		# encrypt the message, encode the encrypted message
		encrypted = cipher.update(str)
		encrypted << cipher.final

		# Encode the encrypted message
		encoded_output = Base64.encode64(encrypted)

		# Now we can do something with output, like update a value in yml.
		puts "Encryption Output: #{encoded_output}\n"

		# Return the encryption key, to store it later.
		return key, iv
	end

	def decrypt(key, iv, msg)
		# Todo -> need to incorporate cipher decryption here.
		return "decrypted"
	end

end


# - So far, this main can just excersize the encryption method, only.
# The decryption method is still a to-do.

## MAIN ##

crypto_handler = BaseEncryptionHandler.new()

puts "[+] Encrypt, Decrypt, or Store Key?"
answer = gets.chomp

if ['Encrypt', 'encrypt'].include?(answer)
	puts "[+] Enter text to encrypt: "
	msg = gets.chomp

	crypto_key, crypto_iv = crypto_handler.encrypt(msg)
	crypto_handler.write_key_to_file(crypto_key)

elsif ['Decrypt', 'decrypt'].include?(answer)
	puts "[+] Enter text to decrypt: "
	msg = gets.chomp

	# Todo -> Need a way to crypto_handler.read_key_from_file here, to get key and iv.
	# key, iv = crypto_handler.read_key_from_file
	decrypted_string = crypto_handler.decrypt(key, iv, msg)


else
	puts "[-] Bad Input. Quitting."

end
