module Chessington
  module Engine
    ##
    # An abstract base class from which all pieces inherit.
    module Piece
      attr_reader :player

      def initialize(player)
        @player = player
        @has_moved = false
      end

      ##
      #  Get all squares that the piece is allowed to move to.
      def available_moves(board)
        raise "Not implemented"
      end

      ##
      # Move this piece to the given square on the board.
      def move_to(board, new_square)
        current_square = board.find_piece(self)
        board.move_piece(current_square, new_square)
        @has_moved = true
      end

      def available_lateral_moves(board)
        [
          available_moves_in_direction(board) { |s| Square.at(s.row + 1, s.column) },
          available_moves_in_direction(board) { |s| Square.at(s.row - 1, s.column) },
          available_moves_in_direction(board) { |s| Square.at(s.row, s.column + 1) },
          available_moves_in_direction(board) { |s| Square.at(s.row, s.column - 1) }
        ].flat_map(&:to_a).to_a
      end

      def available_diagonal_moves(board)
        [
          available_moves_in_direction(board) { |s| Square.at(s.row + 1, s.column + 1) },
          available_moves_in_direction(board) { |s| Square.at(s.row - 1, s.column - 1) },
          available_moves_in_direction(board) { |s| Square.at(s.row - 1, s.column + 1) },
          available_moves_in_direction(board) { |s| Square.at(s.row + 1, s.column - 1) }
        ].flat_map(&:to_a).to_a
      end

      def available_moves_in_direction(board, &direction_function)
        Enumerator.new do |yielder|
          next_square = direction_function.call(board.find_piece(self))
          while free_or_capturable?(board, next_square)
            yielder.yield next_square
            break if board.square_is_occupied?(next_square)
            next_square = direction_function.call(next_square)
          end
        end
      end

      def free_or_capturable?(board, square)
        board.square_in_bounds?(square) && (board.square_is_empty?(square) || piece_capturable?(board.get_piece(square)))
      end

      def square_capturable?(board, square)
        board.square_in_bounds?(square) && board.square_is_occupied?(square) && piece_capturable?(board.get_piece(square))
      end

      def piece_capturable?(piece)
        piece.player != @player
      end
    end

    ##
    # A class representing a chess pawn.
    class Pawn
      include Piece

      def available_moves(board)
        location = board.find_piece(self)
        delta = @player == Chessington::Engine::Player::WHITE ? 1 : -1

        single_move_square = Square.at(location.row + delta, location.column)
        double_move_square = Square.at(location.row + 2 * delta, location.column)

        normal_moves = if !board.square_in_bounds?(single_move_square) || board.square_is_occupied?(single_move_square)
          []
        elsif @has_moved || !board.square_in_bounds?(double_move_square) || board.square_is_occupied?(double_move_square)
          [single_move_square]
        else
          [single_move_square, double_move_square]
        end

        capture_moves = [Square.at(location.row + delta, location.column + 1), Square.at(location.row + delta, location.column - 1)]
          .filter { |square|
          square_capturable?(board, square)
        }

        capture_moves + normal_moves
      end
    end

    ##
    # A class representing a chess knight.
    class Knight
      include Piece

      def available_moves(board)
        location = board.find_piece(self)
        row, col = location.row, location.column

        candidate_moves = [
          Square.at(row + 2, col + 1), Square.at(row + 2, col - 1),
          Square.at(row + 1, col + 2), Square.at(row + 1, col - 2),
          Square.at(row - 2, col + 1), Square.at(row - 2, col - 1),
          Square.at(row - 1, col + 2), Square.at(row - 1, col - 2),
        ]

        candidate_moves.filter do |square|
          free_or_capturable?(board,square)
        end
      end
    end

    ##
    # A class representing a chess bishop.
    class Bishop
      include Piece

      def available_moves(board)
        available_diagonal_moves(board)
      end
    end

    ##
    # A class representing a chess rook.
    class Rook
      include Piece

      def available_moves(board)
        available_lateral_moves(board)
      end
    end

    ##
    # A class representing a chess queen.
    class Queen
      include Piece

      def available_moves(board)
        available_diagonal_moves(board) + available_lateral_moves(board)
      end
    end

    ##
    # A class representing a chess king.
    class King
      include Piece

      def available_moves(board)
        location = board.find_piece(self)
        row, col = location.row, location.column

        candidate_moves = [
          Square.at(row + 1, col + 1), Square.at(row + 1, col), Square.at(row + 1, col - 1),
          Square.at(row, col + 1), Square.at(row, col - 1),
          Square.at(row - 1, col + 1), Square.at(row - 1, col), Square.at(row - 1, col - 1)
        ]

        candidate_moves.filter do |square|
          free_or_capturable?(board,square)
        end
      end
    end
  end
end
