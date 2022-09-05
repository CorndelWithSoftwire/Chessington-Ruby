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

    def test_white_pawn_can_move_up_two_squares_if_not_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(1, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(3, 4))
    end

    def test_black_pawn_can_move_down_two_squares_if_not_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(6, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(4, 4))
    end

    def test_white_pawn_cannot_move_up_two_squares_if_already_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      starting_square = Square.at(1, 4)
      board.set_piece(starting_square, pawn)

      intermediate_square = Square.at(2, 4)
      pawn.move_to(board, intermediate_square)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 4))

    end

    def test_black_pawn_cannot_move_down_two_squares_if_already_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      starting_square = Square.at(6, 4)
      board.set_piece(starting_square, pawn)

      intermediate_square = Square.at(5, 4)
      pawn.move_to(board, intermediate_square)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(3, 4))

    end

    def test_white_pawn_cannot_move_if_piece_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(4, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(5, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_black_pawn_cannot_move_if_piece_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(3, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_white_pawn_cannot_move_two_squares_if_piece_two_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(1, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(3, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, obstructing_square)

    end

    def test_black_pawn_cannot_move_two_squares_if_piece_two_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(6, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(4, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, obstructing_square)

    end

    def test_white_pawn_cannot_move_two_squares_if_piece_one_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(1, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(2, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(3, 4))

    end

    def test_black_pawn_cannot_move_two_squares_if_piece_one_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(6, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(5, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 4))

    end

    def test_white_pawn_cannot_move_at_top_of_board

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(7, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_black_pawn_cannot_move_at_bottom_of_board

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(0, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_white_pawns_can_capture_diagonally

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy1 = Pawn.new(Player::BLACK)
      enemy1_square = Square.at(4, 5)
      board.set_piece(enemy1_square, enemy1)

      enemy2 = Pawn.new(Player::BLACK)
      enemy2_square = Square.at(4, 3)
      board.set_piece(enemy2_square, enemy2)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, enemy1_square)
      assert_includes(moves, enemy2_square)

    end

    def test_black_pawns_can_capture_diagonally

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy1 = Pawn.new(Player::WHITE)
      enemy1_square = Square.at(2, 5)
      board.set_piece(enemy1_square, enemy1)

      enemy2 = Pawn.new(Player::WHITE)
      enemy2_square = Square.at(2, 3)
      board.set_piece(enemy2_square, enemy2)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, enemy1_square)
      assert_includes(moves, enemy2_square)

    end

    def test_white_pawns_cannot_move_diagonally_except_to_capture

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(4, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 3))
      refute_includes(moves, Square.at(4, 5))

    end

    def test_black_pawns_cannot_move_diagonally_except_to_capture

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(2, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 3))
      refute_includes(moves, Square.at(2, 5))
    end
  end

  class TestKnight < Minitest::Test
    include Chessington::Engine

    def test_knight_can_move_in_l_shape

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, knight)

      # Act
      moves = knight.available_moves(board)

      # Assert
      expected_moves = [
        Square.at(4, 7), Square.at(4, 3), Square.at(5, 6), Square.at(5, 4),
        Square.at(2, 7), Square.at(2, 3), Square.at(1, 6), Square.at(1, 4)
      ]
      assert_equal(moves.length, expected_moves.length)
      assert_equal(moves.to_set, expected_moves.to_set)

    end

    def test_knight_can_jump_over_pieces

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, knight)

      # Put piece surrounding the knight
      (-1..1).each { |row_delta|
        (-1..1).each { |col_delta|
          if row_delta != 0 || col_delta != 0
            board.set_piece(Square.at(square.row + row_delta, square.column + col_delta), Pawn.new(Player::WHITE))
          end
        }
      }

      # Act
      moves = knight.available_moves(board)

      # Assert
      expected_moves = [
        Square.at(4, 7), Square.at(4, 3), Square.at(5, 6), Square.at(5, 4),
        Square.at(2, 7), Square.at(2, 3), Square.at(1, 6), Square.at(1, 4)
      ]
      assert_equal(moves.length, expected_moves.length)
      assert_equal(moves.to_set, expected_moves.to_set)

    end

    def test_knight_cannot_leave_the_board

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      square = Square.at(7, 7)
      board.set_piece(square, knight)

      # Act
      moves = knight.available_moves(board)

      # Assert
      expected_moves = [Square.at(5, 6), Square.at(6, 5)]
      assert_equal(moves.length, expected_moves.length)
      assert_equal(moves.to_set, expected_moves.to_set)

    end

    def test_knight_can_capture_enemy_pieces

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, knight)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(1, 4)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = knight.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_knight_cannot_capture_friendly_pieces

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, knight)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(1, 4)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = knight.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end
  end

  class TestBishop < Minitest::Test
    include Chessington::Engine

    def test_bishop_can_move_diagonally

      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      expected_moves = [
        Square.at(0, 2), Square.at(1, 3), Square.at(2, 4), Square.at(4, 6), Square.at(5, 7),
        Square.at(1, 7), Square.at(2, 6), Square.at(4, 4), Square.at(5, 3), Square.at(6, 2), Square.at(7, 1)
      ]
      assert_equal(moves.length, expected_moves.length)
      assert_equal(moves.to_set, expected_moves.to_set)

    end

    def test_bishop_can_capture_enemy_pieces

      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(5, 3)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_bishop_is_blocked_by_enemy_pieces

      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(5, 3)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(6, 2))

    end

    def test_bishop_cannot_capture_friendly_pieces

      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(5, 3)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)

    end

    def test_bishop_is_blocked_by_friendly_pieces

      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(3, 5)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(5, 3)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(6, 2))

    end
  end

  class TestRook < Minitest::Test
    include Chessington::Engine

    def test_rook_can_move_laterally

      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(2, 5)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      expected_moves = [
        Square.at(2, 0), Square.at(2, 1), Square.at(2, 2), Square.at(2, 3), Square.at(2, 4), Square.at(2, 6), Square.at(2, 7),
        Square.at(0, 5), Square.at(1, 5), Square.at(3, 5), Square.at(4, 5), Square.at(5, 5), Square.at(6, 5), Square.at(7, 5)
      ]
      assert_equal(moves.length, expected_moves.length)
      assert_equal(moves.to_set, expected_moves.to_set)

    end

    def test_rook_can_capture_enemy_pieces

      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(2, 5)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 5)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_rook_is_blocked_by_enemy_pieces

      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(2, 5)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(1, 5)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(0, 5))

    end

    def test_rook_cannot_capture_friendly_pieces

      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(2, 5)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(6, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)

    end

    def test_rook_is_blocked_by_friendly_pieces

      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(2, 5)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(1, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(0, 5))
    end
  end

  class TestQueen < Minitest::Test
    include Chessington::Engine

    def test_queen_can_move_diagonally_and_laterally

      # Arrange
      board = Board.empty
      queen = Queen.new(Player::WHITE)
      square = Square.at(4, 4)
      board.set_piece(square, queen)

      # Act
      moves = queen.available_moves(board)

      # Assert
      expected_moves = [
        Square.at(0, 0), Square.at(1, 1), Square.at(2, 2), Square.at(3, 3), Square.at(5, 5), Square.at(6, 6), Square.at(7, 7),
        Square.at(1, 7), Square.at(2, 6), Square.at(3, 5), Square.at(5, 3), Square.at(6, 2), Square.at(7, 1),
        Square.at(0, 4), Square.at(1, 4), Square.at(2, 4), Square.at(3, 4), Square.at(5, 4), Square.at(6, 4), Square.at(7, 4),
        Square.at(4, 0), Square.at(4, 1), Square.at(4, 2), Square.at(4, 3), Square.at(4, 5), Square.at(4, 6), Square.at(4, 7)
      ]
      assert_equal(moves.length, expected_moves.length)
      assert_equal(moves.to_set, expected_moves.to_set)

    end

    def test_queen_can_capture_enemy_pieces

      # Arrange
      board = Board.empty
      queen = Queen.new(Player::WHITE)
      square = Square.at(4, 4)
      board.set_piece(square, queen)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = queen.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_queen_is_blocked_by_enemy_pieces

      # Arrange
      board = Board.empty
      queen = Queen.new(Player::WHITE)
      square = Square.at(4, 4)
      board.set_piece(square, queen)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = queen.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(7, 7))

    end

    def test_queen_cannot_capture_friendly_pieces

      # Arrange
      board = Board.empty
      queen = Queen.new(Player::WHITE)
      square = Square.at(4, 4)
      board.set_piece(square, queen)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(6, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = queen.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)

    end

    def test_queen_is_blocked_by_friendly_pieces

      # Arrange
      board = Board.empty
      queen = Queen.new(Player::WHITE)
      square = Square.at(4, 4)
      board.set_piece(square, queen)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(6, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = queen.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(7, 7))
    end
  end

  class TestKing < Minitest::Test
    include Chessington::Engine

    def test_king_can_move_one_square_in_any_direction()
      # Arrange
      board = Board.empty
      king = King.new(Player::WHITE)
      square = Square.at(5, 2)
      board.set_piece(square, king)

      # Act
      moves = king.available_moves(board)

      # Assert
      expected_moves = [
        Square.at(4, 1), Square.at(4, 2), Square.at(4, 3), Square.at(5, 1),
        Square.at(5, 3), Square.at(6, 1), Square.at(6, 2), Square.at(6, 3)
      ]
      assert_equal(moves.length, expected_moves.length)
      assert_equal(moves.to_set, expected_moves.to_set)

    end

    def test_king_cannot_move_off_the_board()

      # Arrange
      board = Board.empty
      king = King.new(Player::WHITE)
      square = Square.at(7, 7)
      board.set_piece(square, king)

      # Act
      moves = king.available_moves(board)

      # Assert
      expected_moves = [Square.at(7, 6), Square.at(6, 6), Square.at(6, 7)]
      assert_equal(moves.length, expected_moves.length)
      assert_equal(moves.to_set, expected_moves.to_set)

    end

    def test_king_can_capture_enemy_pieces()

      # Arrange
      board = Board.empty
      king = King.new(Player::WHITE)
      square = Square.at(5, 2)
      board.set_piece(square, king)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(5, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = king.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_king_cannot_capture_friendly_pieces()

      # Arrange
      board = Board.empty
      king = King.new(Player::WHITE)
      square = Square.at(5, 2)
      board.set_piece(square, king)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(5, 1)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = king.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end
  end
end
