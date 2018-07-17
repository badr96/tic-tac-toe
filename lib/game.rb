# frozen_string_literal: true

class Game
  attr_accessor :players, :board, :turn

  def initialize
    @players = [Player.new('X'), Player.new('O')]
    @board = Board.new
    @turn = 0
    set_players_name
  end

  def play
    loop do
      play_turn
      break if [true, 'full'].include? @board.status
    end
    if @board.status == true
      puts "There was a winner, congratulations #{@players[@turn].name}"
    else
      puts "The game is null. Nobody won"
    end
    @board.print_board
  end

  private

  def set_players_name
    (0..1).each do |number|
      puts "What is the name of player #{number + 1} ?"
      print '> '
      @players[number].name = gets.chomp
    end
  end

  def play_turn
    loop do
      @board.print_board_example
      puts "#{@players[@turn].name} turn's to play"
      puts "Where do you wish to play ?"
      print "Available cases are : "
      @board.available_cases.each{ |x| print "#{x + 1} " }
      puts ''
      print '> '
      choice = gets.chomp.to_i - 1
      break if @board.try_play(choice, @players[@turn])
    end
    @turn = @turn.zero? ? 1 : 0 if ![true, 'full'].include? @board.status
  end
end
