require 'zlib'

class Ringo
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
		return encrypted_string
	end

	def self.decrypt(str)
	 begin
   	s = Zlib::Inflate.inflate(str)
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
		rescue Exception => e
 		 puts "Issue: #{e}"
 	 end
	end
end

puts "Encrypt or Decrypt?"
answer = gets.chomp

if ['Encrypt', 'encrypt'].include?(answer)
	puts "Enter text:"
	msg = gets.chomp
	p "\nEncrypted Message: #{Ringo.encrypt(msg)}"
else
	puts "Enter encrypted text:"
	msg = gets.chomp
	p "\nDecrypted Message: #{Ringo.decrypt(msg)}"
end
