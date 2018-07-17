# frozen_string_literal: true

class BoardCase
  attr_accessor :status

  def initialize
    @status = ' '
  end

  def to_s
    @status
  end
end
