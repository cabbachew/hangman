puts "Hangman initialized."

all_words = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)

word_pool = all_words.select do |word|
  word.length >= 5 && word.length <= 12
end

class Hangman
  def initialize(word_pool)
    @answer = word_pool.sample
    @ans_array = answer.split("")
    @remaining_guesses = answer.length
  end
  attr_reader :answer, :ans_array, :remaining_guesses

# # Store answer in an array
# ans_array = answer.split("")

# # Print "__" for each letter in answer array
# puts ans_array.map {|c| "__"}.join("  ")

# # Set number of guesses to letter count
# remaining_guesses = ans_array.length

  def play
    print_remaining_guesses(remaining_guesses)
  end

  def print_remaining_guesses(remaining_guesses)
    puts "Guesses remaining: #{remaining_guesses}"
  end

# print "Pick a letter: "

# guess = gets.chomp.downcase

# puts "The answer is: #{answer}"
# puts "You guessed: #{guess}"

end

Hangman.new(word_pool).play
