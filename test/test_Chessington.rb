require_relative "test_helper"

#
# from chessington.engine.board import Board
# from chessington.engine.data import Player, Square
#
# def test_new_board_has_white_pieces_at_bottom():
#
#   # Arrange
#   board = Board.at_starting_position()
#
#   # Act
#   piece = board.get_piece(Square.at(0, 0))
#
#   # Assert
#   assert piece.player == Player.WHITE
#
# def test_new_board_has_black_pieces_at_top():
#
#   # Arrange
#   board = Board.at_starting_position()
#
#   # Act
#   piece = board.get_piece(Square.at(7, 0))
#
#   # Assert
#   assert piece.player == Player.BLACK
#
# def test_pieces_can_be_moved_on_the_board():
#
#   # Arrange
#   board = Board.at_starting_position()
#   from_square = Square.at(1, 0)
#   piece = board.get_piece(from_square)
#
#   # Act
#   to_square = Square.at(3, 0)
#   board.move_piece(from_square, to_square)
#
#   assert board.get_piece(from_square) is None
#   assert board.get_piece(to_square) is piece

class TestChessington < Minitest::Test
  Board = Chessington::Engine::Board
  Square = Chessington::Engine::Square
  Player = Chessington::Engine::Player

  def test_new_board_has_white_pieces_at_bottom
    board = Board.at_starting_position

    piece = board.get_piece(Square.new(0, 0))

    assert_equal(piece.player, Player::WHITE)
  end

  def test_new_board_has_black_pieces_at_top
    board = Board.at_starting_position

    piece = board.get_piece(Square.new(7, 0))

    assert_equal(piece.player, Player::BLACK)
  end

  def test_pieces_can_be_moved_on_the_board
    board = Board.at_starting_position
    from_square = Square.new(1,0)
    piece = board.get_piece(from_square)

    to_square = Square.new(3,0)
    board.move_piece(from_square,to_square)

    assert_nil(board.get_piece(from_square))
    assert_equal(board.get_piece(to_square), piece)
  end
end
