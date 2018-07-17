# frozen_string_literal: true

# contains the board and its cases, aswell as the methods that modify/check on the state of the board
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

  def print_board_example
    puts ''
    puts " #{@boardcases[0]} | #{@boardcases[1]} | #{@boardcases[2]}       1 | 2 | 3"
    puts '---|---|---     ---|---|---'
    puts " #{@boardcases[3]} | #{@boardcases[4]} | #{@boardcases[5]}       4 | 5 | 6"
    puts '---|---|---     ---|---|---'
    puts " #{@boardcases[6]} | #{@boardcases[7]} | #{@boardcases[8]}       7 | 8 | 9"
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
