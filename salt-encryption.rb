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
    return arr.join("")
	end

	def self.decrypt(str)
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

puts "Encrypt or Decrypt?"
answer = gets.chomp

if ['Encrypt', 'encrypt'].include?(answer)
	puts "Enter text:"
	msg = gets.chomp
	puts "\nEncrypted Message: #{Ringo.encrypt(msg)}"
else
	puts "Enter encrypted text:"
	msg = gets.chomp
	puts "\nDecrypted Message: #{Ringo.decrypt(msg)}"
end
