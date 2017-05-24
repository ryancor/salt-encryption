require 'zlib'

class Ringo
	def self.store_key(key)
		file = File.open("~/.store_keys.txt", 'w')
		file.write(key)
	end

	def self.encrypt(str)
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

	def self.decrypt(str)
		s = str.split("")
		arr = []
		split.each_with_index do |v, i|
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

puts "Encrypt, Decrypt, or Store Key?"
answer = gets.chomp

if ['Encrypt', 'encrypt'].include?(answer)
	puts "Enter text:"
	msg = gets.chomp
	puts "\n"
	p "Encrypted Message: #{Ringo.encrypt(msg)}"
elsif ['Store', 'store'].include?(answer)
	puts "\necho '{key}' >> store_keys.txt"
else
	puts "\nDecrypted Message: #{Ringo.decrypt}"
end
