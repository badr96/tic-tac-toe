# frozen_string_literal: true

# one case on the boardgame, contains only its own status
class BoardCase
  attr_accessor :status

  def initialize
    @status = ' '
  end

  def to_s
    @status
  end
end
