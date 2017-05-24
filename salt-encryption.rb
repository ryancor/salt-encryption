class BaseEncryptionHandler

	def store_key(key)
		# Appends to the file. if the file doesnt exist, makes a new one.
		file = File.open(File.join(ENV['HOME'], ".store_keys.txt"), 'a+')
		file.write(key + "\n")
	end

	def encrypt(str)
		s = str.split("")
		arr = []
		s.each_with_index do |v, i|
			if i.between?(0,5)
				arr << (v.codepoints.first + 3).chr
		 	elsif i.between?(6, 10)
				arr << (v.codepoints.first + 8).chr
			elsif i > 10
				arr << (v.codepoints.first + 5).chr
			end
		end
		return arr.join("")
	end

	def decrypt(str)
		s = str.split("")
		arr = []
		s.each_with_index do |v, i|
			if i.between?(0, 5)
				arr << (v.codepoints.first - 3).chr
			elsif i.between?(6, 10)
				arr << (v.codepoints.first - 8).chr
			elsif i > 10
				arr << (v.codepoints.first - 5).chr
			end
		end
		return arr.join("")
	end

end


# - So far, this main just instantiates the encryption class,
# - and uses its methods only.

## MAIN ##

crypt_handler = BaseEncryptionHandler.new()

puts "Encrypt, Decrypt, or Store Key?"
answer = gets.chomp

if ['Encrypt', 'encrypt'].include?(answer)
	puts "Enter text to encrypt: "
	msg = gets.chomp
	puts "\n"
	puts "Encrypted Message: #{crypt_handler.encrypt(msg)}"

elsif ['Store', 'store'].include?(answer)
	puts "Enter key: "
	msg = gets.chomp
	crypt_handler.store_key(msg)

else
	puts "Enter text to decrypt: "
	msg = gets.chomp
	puts "\nDecrypted Message: #{crypt_handler.decrypt(msg)}"

end
