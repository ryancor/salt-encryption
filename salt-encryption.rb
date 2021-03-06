require 'zlib'

class Ringo
	def self.store_key(key)
		file = File.open("store_keys.txt", 'w')
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
    encrypted_string = Zlib::Deflate.deflate(arr.join(""))
		file = File.open("store_keys.txt", 'w')
		file.write(encrypted_string)
		return encrypted_string
	end

	def self.decrypt
	 begin
		 File.open("store_keys.txt").each do |line|
			 s = Zlib::Inflate.inflate(line)
			 split = s.split("")
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
		    decrypted_string = arr.join("")
				return decrypted_string
		 end
		rescue Exception => e
 		 puts "Issue: #{e}"
 	 end
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
