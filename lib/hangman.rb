puts "Hangman initialized."

class Hangman

  def initialize(word_pool)
    # Generate and store answer in array
    @answer = word_pool.sample.split("") 
    @remaining_guesses = answer.length
    @raw_board = answer.map {|c| "_"}
    @board = answer.map {|c| "_"}.join("  ")
  end
  attr_reader :answer, :remaining_guesses
  attr_accessor :board, :raw_board

  def play
    puts "The answer is: #{answer.join("")}" # temporary
    print_board # Start with empty board

    while board.split != answer do
      guess = get_player_guess
      puts "You guessed: #{guess}"

      # Check guess
      if answer.include?(guess)
        puts "THERE WAS A MATCH!"
        # X Board state must be saved by remapping the board while
        # checking against same index in answer
        @board = answer.map {|c| c == guess ? c : "_"}.join("  ")
        update_board(guess)
        print_board
      else
        puts "WRONG GUESS!"
        print_board
      end

      @remaining_guesses -= 1
      print_remaining_guesses(@remaining_guesses)
    end
  end

  def update_board(guess)
    answer.each_with_index do |char, index|
      if guess == char
        @raw_board[index] = char
      end
    end
    puts raw_board.join("  ")
  end

  def print_board
    puts @board
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

all_words = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)

word_pool = all_words.select do |word|
  word.length >= 5 && word.length <= 12
end

Hangman.new(word_pool).play
