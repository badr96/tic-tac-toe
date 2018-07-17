# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/board'
require_relative 'lib/boardcase'

def main
  game = Game.new
  game.play
end

main
