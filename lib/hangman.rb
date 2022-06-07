# To-do:
# - Refactor
# - Implement new game / load game
# - Implement quit game
# - Enable user to create filename
#   * Currently using Time.now to generate unique id
# - Enable file rewriting during save
# * Review: https://github.com/andrewjh271/hangman
# ✓ Colorize output text: https://github.com/fazibear/colorize

require 'time'
require 'yaml'
require_relative 'colorize'

puts "Hangman initialized.".light_blue

class Hangman

  def initialize(word_pool)
    # Generate and store answer in array
    @answer = word_pool.sample.split("") 
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
        puts "THERE WAS A MATCH!".green
        update_board(guess)
      else
        puts "WRONG GUESS!".red
        @remaining_attempts -= 1 # Decrement remaining guesses
      end

      print_board
      print_remaining_attempts(@remaining_attempts)
      puts
    end
    if @board == @answer
      puts "You win!".green
    else
      puts "Game over! The answer was #{@answer.join("")}".red
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
      # Enable save
      if guess == "save"
        puts "Saving..."
        save_game(self)
      end
      print "Pick a valid letter: "
      guess = gets.chomp.downcase
    end
    while @past_guesses.include?(guess)
      puts "Past guesses: #{@past_guesses.join(" | ")}".yellow
      print "Guess something new: "
      guess = gets.chomp.downcase
    end

    @past_guesses << guess
    puts "You guessed: #{guess}"
    return guess
  end

  def save_game(game)
    Dir.mkdir('saved') unless Dir.exist?('saved')
    unique_id = Time.now.strftime("%y%m%d%H%M%S")
    filename = "saved/#{unique_id}.yaml"
    File.open(filename, 'w') { |file| file.write YAML.dump(game) }
  end

  def load_game
    begin
      filenames = Dir.glob('saved/*').map do |file| 
        file[(file.index('/') + 1)...(file.index('.'))]
      end
      puts "Saved games:"
      puts filenames
      filename = gets.chomp
      raise "#{filename} does not exist." unless filenames.include?(filename)
      puts "Loading #{filename}..."
      loaded_game = YAML.load(File.read("saved/#{filename}.yaml"))
      loaded_game.play
    rescue StandardError => e
      puts e
      retry
    end
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

# Load game
# Hangman.new(word_pool).load_game
# puts
