# To-do:
# - Save functionality (i.e. word, board, remaining guesses, past guesses)
#   - File naming protocol
puts "Hangman initialized."

class Hangman
  def initialize(word_pool)
    # Generate and store answer in array
    @answer = word_pool.sample.split("") 
    # puts "The answer is: #{@answer.join("")}" # Cheat mode
    @remaining_attempts = 6
    # * Initialize empty board as an array
    @board = @answer.map {|c| "_"}
    @past_guesses = []
  end

  def play
    print_board # Start with empty board

    while @board != @answer && @remaining_attempts > 0 do
      guess = get_player_guess
      # Check guess
      if @answer.include?(guess)
        puts "THERE WAS A MATCH!"
        update_board(guess)
      else
        puts "WRONG GUESS!"
        @remaining_attempts -= 1 # Decrement remaining guesses
      end

      print_board
      print_remaining_attempts(@remaining_attempts)
      puts
    end
    if @board == @answer
      puts "You win!"
    else
      puts "Game over! The answer was #{@answer.join("")}"
    end
  end

  def update_board(guess)
    @answer.each_with_index do |char, index|
      if guess == char
        @board[index] = char
      end
    end
  end

  def print_board
    puts @board.join("  ")
    puts
  end

  def print_remaining_attempts(remaining_attempts)
    puts "Attempts remaining: #{remaining_attempts}"
  end

  def get_player_guess
    print "Pick a letter: "
    guess = gets.chomp.downcase
    # Prompt for valid guess
    until guess.match(/[a-z]/) && guess.length == 1 do
      print "Pick a valid letter: "
      guess = gets.chomp.downcase
      # Easter egg
      if guess.include?("fuck")
        puts "Fuck you brah, how about get gud instead?"
      end
    end
    while @past_guesses.include?(guess)
      puts "Past guesses: #{@past_guesses.join(" | ")}"
      print "Guess something new: "
      guess = gets.chomp.downcase
    end

    @past_guesses << guess
    puts "You guessed: #{guess}"
    return guess
  end
end

# Read all words from text file
all_words = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)
# Create pool of words within character range (5-12)
word_pool = all_words.select do |word|
  word.length >= 5 && word.length <= 12
end

# Play game
Hangman.new(word_pool).play
puts
