require "glimmer-dsl-gtk"

module Chessington
  class Ui
    include Glimmer

    BOARD_SIZE = Chessington::Engine::Board::BOARD_SIZE
    Player = Chessington::Engine::Player
    Square = Chessington::Engine::Square
    BLACK_SQUARE = [0xB5, 0x88, 0x63]
    WHITE_SQUARE = [0xF0, 0xD9, 0xB5]

    def initialize
      @from_square = nil
      @to_squares = []
    end

    def launch
      @game_board = Chessington::Engine::Board.at_starting_position
      create_gui
      @main_window.show
    end

    def create_gui
      @main_window = window {
        title "Chessington"
        default_size BOARD_SIZE*64, BOARD_SIZE*64 # + 98

        box(:vertical) {
          @board = []
          BOARD_SIZE.times do |row|
            @board << []
            box(:horizontal) {
              BOARD_SIZE.times do |column|
                board_space = {}
                area = drawing_area {
                  paint 242.25, 242.25, 242.25

                  size_request 64, 64

                  board_space[:box] = square(0, 0, 64) {
                    fill (row + column).even? ? WHITE_SQUARE : BLACK_SQUARE
                  }

                  piece = @game_board.get_piece(Square.new(row, column))

                  board_space[:piece] = square(0, 0, 64) {
                    unless piece.nil?
                      image = Cairo::ImageSurface.from_png("images/#{piece.class.name.downcase.split('::').last}#{piece.player == Player::WHITE ? "w" : "b"}.png")
                      fill([image])
                    end
                  }

                  on(:button_press_event) do |widget, event|
                    handle_click Square.new(row, column) if event.button == 1
                  end
                }
                board_space[:area] = area
                @board.last << board_space

                area.add_events(Gdk::EventMask::BUTTON_PRESS_MASK | Gdk::EventMask::POINTER_MOTION_MASK)

              end
            }
          end
        }
      }
    end

    def handle_click(clicked_square)
      clicked_piece = @game_board.get_piece(clicked_square)

      if !@from_square.nil? && @to_squares.include?(clicked_square)
        @game_board.get_piece(@from_square).move_to(@game_board, clicked_square)
        @from_square, @to_squares = nil, []
      elsif !clicked_piece.nil? && clicked_piece.player == @game_board.current_player
        @from_square = clicked_square
        @to_squares = clicked_piece.get_available_moves(@game_board)
      else
        @from_square, @to_squares = nil, []
      end
      update_squares
    end

    def update_squares
      BOARD_SIZE.times do |row|
        BOARD_SIZE.times do |column|
          square = Square.new(row, column)
          board_square = @board[row][column]
          board_square[:box].fill = if square == @from_square
            [230, 230, 230]
          elsif @to_squares.include? square
            [120, 230, 180]
          else
            (row + column).even? ? WHITE_SQUARE : BLACK_SQUARE
          end

          piece = @game_board.get_piece(square)
          board_square[:piece].fill = if piece.nil?
            nil
          else
            image = Cairo::ImageSurface.from_png("images/#{piece.class.name.downcase.split('::').last}#{piece.player == Player::WHITE ? "w" : "b"}.png")
            [image]
          end

          board_square[:area].queue_draw
        end
      end
    end
  end
end
