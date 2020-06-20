class TicTacToe
  @@board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  @@player = "O"

  def self.reset_board
    @@board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def self.display
    puts "-" * 13
    @@board.each do |row|
      puts("| #{row[0]} | #{row[1]} | #{row[2]} |")
    end
    puts "-" * 13
  end

  def self.get_columns
    @@board.transpose
  end

  def self.get_diagonals
    [(0..2).collect { |index| @@board[index][index] },
     (0..2).collect { |index| @@board.reverse[index][index] }]
  end

  def self.isWinning(x_or_o)
    @@board.each do |row|
      if row.count(x_or_o) === 3
        return true
      end
    end
    self.get_columns.each do |column|
      if column.count(x_or_o) == 3
        return true
      end
    end
    self.get_diagonals.each do |diagonal|
      if diagonal.count(x_or_o) == 3
        return true
      end
    end
    false
  end

  def self.xo_count
    count = 0
    @@board.each do |row|
      count += row.count("X") + row.count("O")
    end
    count
  end

  def self.outcomes
    if isWinning("X")
      return "X wins!"
    end
    if isWinning("O")
      return "O wins!"
    end
    if xo_count == 9
      return "It's a draw"
    end
    false
  end

  def self.player_move
    @@player = @@player == "O" ? "X" : "O";
    puts "Actual player: #{@@player}"
    coordinate = self.get_input
    @@board[coordinate/3][coordinate%3] = @@player
  end

  def self.get_input
    print "Enter the number of a cell: "
    coordinate = gets.chomp
    if coordinate.length != 1
      puts "Enter a single number!"
      return self.get_input
    end
    if coordinate.to_i.to_s == coordinate
      coordinate = coordinate.to_i - 1
      if coordinate > 8
        puts "Enter a valid number!"
        return self.get_input
      end
      if @@board[coordinate/3][coordinate%3] == "X" || @@board[coordinate/3][coordinate%3] == "O"
        puts "This cell is occupied! Choose another one!"
        return self.get_input
      end
      return coordinate
    end
    puts "Enter a number!"
    self.get_input
  end

  def self.play
    self.display
    until self.outcomes
      self.player_move
      print "\e[2J\e[f" # Clear the output.
      self.display
    end
    puts self.outcomes
    self.reset_board
  end
end

TicTacToe.play