class Game
  attr_accessor :board, :player_1, :player_2

  # Win combinations constant
  WIN_COMBINATIONS = [
    [0, 1, 2], # Top row
    [3, 4, 5], # Middle row
    [6, 7, 8], # Bottom row
    [0, 3, 6], # Left column
    [1, 4, 7], # Middle column
    [2, 5, 8], # Right column
    [0, 4, 8], # Left Diagonal
    [2, 4, 6]  # Right Diagonal
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    board.turn_count.odd? ? player_2 : player_1
  end

  def won?
    # THIS FUCKING SUCKEDDDD
    win = false
    WIN_COMBINATIONS.each do |combo|
      win = combo if check_combo(combo)
    end
    win
  end

  def check_combo(combo)
    win = false
    poss_win = []
    combo.each {|i| poss_win << board.cells[i]}
    win = combo if poss_win == ["X", "X", "X"] || poss_win == ["O", "O", "O"]
    win
  end

  def draw?
    board.full? && !self.won?
  end

  def over?
    board.full?
  end

  def winner
    board.cells[self.won?&.first] if won?
  end
  
  def turn
    puts "Make your move."
    input = current_player.move(board)
    if !board.valid_move?(input)
      puts "Choose a different move."
      input = current_player.move(board)
    else
      board.update(input, current_player)
    end
  end

  def play
    turn

    


  end

end