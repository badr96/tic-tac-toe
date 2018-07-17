# frozen_string_literal: true

class Game
  attr_accessor :players, :board, :turn

  def initialize
    @players = [Player.new('X'), Player.new('O')]
    @board = Board.new
    @turn = 0
    set_players_name
  end

  def play_turn
    loop do
      @board.print_board
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
end

class Player
  attr_accessor :name, :tick

  def initialize(tick)
    @name = ''
    @tick = tick
  end
end

class Board
  attr_accessor :boardcases

  def initialize
    @boardcases = []
    9.times{ @boardcases.push(BoardCase.new) }
  end

  def status
    return 'full' if check_board_full && !check_winner
    check_winner
  end

  def try_play(index, player)
    if !(0..8).cover? index
      puts "Index out of bounds, please try again."
      return false
    end
    if @boardcases[index].status == ' '
      @boardcases[index].status = player.tick
      return true
    end
    puts "Boardcase is taken, please try again."
    false
  end

  def print_board
    i = 0
    (0..2).each do |line|
      (0..2).each do |col|
        print " #{@boardcases[i].status} "
        print "|" if col != 2
        i += 1
      end
      puts ''
      puts '---|---|---' if line != 2
    end
  end

  def available_cases
    available = []
    @boardcases.each_with_index do |boardcase, index|
      available.push(index) if boardcase.status == ' '
    end
    available
  end

  private

  def check_board_full
    @boardcases.each do |boardcase|
      return false if boardcase.status == ' '
    end
    true
  end

  def check_winner
    check_diagonal || check_vertical || check_horizontal
  end

  def check_horizontal
    [0, 3, 6].each do |index|
      line = ''
      (0..2).each do |n|
        line += @boardcases[index + n].status
      end
      return true if ['XXX', 'OOO'].include? line
    end
    false
  end

  def check_vertical
    (0..2).each do |index|
      line = @boardcases[index].status + @boardcases[index + 3].status + @boardcases[index + 6].status
      if line == @boardcases[index].status * 3 && @boardcases[index].status != ' '
        return true
      end
    end
    false
  end

  def check_diagonal
    if @boardcases[0].status == @boardcases[4].status && @boardcases[4].status == @boardcases[8].status
      return true if @boardcases[4].status != ' '
    end
    if @boardcases[2].status == @boardcases[4].status && @boardcases[4].status == @boardcases[6].status
      return true if @boardcases[4].status != ' '
    end
    false
  end
end

class BoardCase
  attr_accessor :status

  def initialize
    @status = ' '
  end
end

game = Game.new
game.play
