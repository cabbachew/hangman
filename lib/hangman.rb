puts "Hangman initialized."

all_words = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)

word_pool = all_words.select do |word|
  word.length >= 5 && word.length <= 12
end

puts word_pool
