# frozen_string_literal: true

class Player
  attr_accessor :name, :tick

  def initialize(tick)
    @name = ''
    @tick = tick
  end
end
