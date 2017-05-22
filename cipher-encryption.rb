class Cipher
  def initialize(shuffled)
    alpha = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + [' ']
    @map = alpha.zip(shuffled).inject(:encrypt => {} , :decrypt => {}) do |hash,(a,b)|
      hash[:encrypt][a] = b
      hash[:decrypt][b] = a
      hash
    end
  end

  def encrypt(str)
    str.split(//).map { |char| @map[:encrypt][char] }.join
  end

  def decrypt(str)
    str.split(//).map { |char| @map[:decrypt][char] }.join
  end
end

cipher = Cipher.new ["K", "D", "w", "X", "H", "3", "e", "1", "S",
  "B", "g", "a", "y", "v", "I", "6", "u", "W", "C", "0", "9", "b",
  "z", "T", "A", "q", "U", "4", "O", "o", "E", "N", "f", "n", "G",
  "d", "k", "x", "P", "t", "R", "s", "J", "L", "r", "h", "Z", "j",
  "Y", "5", "7", "l", "p", "c", "2", "8", "M", "V", "m", "i", " ", "Q", "F", "?"]

puts "Encrypt or Decrypt?"
answer = gets.chomp

if ['Encrypt', 'encrypt'].include?(answer)
  puts "Enter message: "
  msg = gets.chomp
  puts cipher.encrypt(msg)
else
  puts "Enter encrypted message: "
  msg = gets.chomp
  puts cipher.decrypt(msg)
end
