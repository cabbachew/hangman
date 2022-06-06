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

  def play
    # Print "__" for each letter in answer array
    puts answer.map {|c| "_"}.join("  ")

    guess = get_player_guess
    puts "You guessed: #{guess}"

    # Check guess
    if answer.include?(guess)
      puts "THERE WAS A MATCH!"
      puts answer.map {|c| c == guess ? guess : "_"}.join("  ")
    end

    @remaining_guesses -= 1
    print_remaining_guesses(@remaining_guesses)

    puts "The answer was: #{answer.join("")}"
  end

  def print_remaining_guesses(remaining_guesses)
    puts "Guesses remaining: #{remaining_guesses}"
  end

  def get_player_guess
    print "Pick a letter: "
    guess = gets.chomp.downcase
    # Prompt for valid guess
    until guess.match(/[a-z]/) && guess.length == 1 do
      print"Pick a valid letter: "
      guess = gets.chomp.downcase
    end
    return guess
  end
end

Hangman.new(word_pool).play
