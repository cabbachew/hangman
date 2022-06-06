puts "Hangman initialized."

all_words = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)

word_pool = all_words.select do |word|
  word.length >= 5 && word.length <= 12
end

class Hangman
  def initialize(word_pool)
    # Generate and store answer in array
    @answer = word_pool.sample.split("") 
    @remaining_guesses = answer.length
  end
  attr_reader :answer, :remaining_guesses

# # Store answer in an array
# ans_array = answer.split("")

# # Print "__" for each letter in answer array
# puts ans_array.map {|c| "__"}.join("  ")

# # Set number of guesses to letter count
# remaining_guesses = ans_array.length

  def play
    guess = get_player_guess
    @remaining_guesses -= 1
    puts "You guessed: #{guess}"

    print_remaining_guesses(@remaining_guesses)

    puts "The answer is: #{answer}"
  end

  def print_remaining_guesses(remaining_guesses)
    puts "Guesses remaining: #{remaining_guesses}"
  end

  def get_player_guess
    print "Pick a letter: "
    return gets.chomp.downcase
  end
end

Hangman.new(word_pool).play
