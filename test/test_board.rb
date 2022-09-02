require_relative "test_helper"

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
