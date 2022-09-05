require_relative "test_helper"
require "Chessington/engine"

class TestPieces < Minitest::Test
  class TestPawn < Minitest::Test
    include Chessington::Engine

    def test_white_pawns_can_move_up_one_square

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(1, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(2, 4))
    end

    def test_black_pawns_can_move_down_one_square

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(6, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(5, 4))
    end
  end
end
