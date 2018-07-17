# frozen_string_literal: true

# players have a name and a tick sign
class Player
  attr_accessor :name, :tick

  def initialize(tick)
    @name = ''
    @tick = tick
  end
end
