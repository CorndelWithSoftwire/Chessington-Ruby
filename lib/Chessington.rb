# frozen_string_literal: true

require_relative "Chessington/version"

module Chessington
  class Error < StandardError; end
  # Your code goes here...

  module Engine
    require_relative "Chessington/engine"
    require_relative "Chessington/engine/board"
    require_relative "Chessington/engine/data"
    require_relative "Chessington/engine/pieces"
  end

  class Ui
    require_relative 'Chessington/ui'
  end
end

Chessington::Ui.new.launch
