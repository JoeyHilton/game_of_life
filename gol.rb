class World
attr_reader :cells, :cells_with_neighbors, :cells_that_should_live, :cells_that_should_die
 
# [
# [cell cell cell],
# [cell cell cell],
# [cell cell cell]
# ]
 
def initialize
  @cells = Array.new(10) { Array.new(10) { Cell.new } }
  @cells_that_should_live = []
  @cells_that_should_die = []
  play_game
end
 
def locate_cells_and_neighbors
  @cells_with_neighbors = []
  @cells.each_with_index do |cell_row, row|
  cell_row.each_with_index do |cell, column|
  live_or_die(cell, row, column)
  end
  end
end
 
def find_neighbors(row, column)
  neighbors = []
  neighbors << cells[row][column + 1] rescue nil
  neighbors << cells[row + 1][column + 1] rescue nil
  neighbors << cells[row + 1][column] rescue nil
  neighbors << cells[row + 1][column - 1] rescue nil
  neighbors << cells[row - 1][column - 1] rescue nil
  neighbors << cells[row - 1][column] rescue nil
  neighbors << cells[row][column - 1] rescue nil
  neighbors << cells[row - 1][column + 1] rescue nil
  neighbors.compact!
  return neighbors
end
 
def find_living_neighbors(cell, row, column)
  find_neighbors(row, column).select { |cell| cell.alive }.length
  end
  def live_or_die(cell, row, column)
  total = find_living_neighbors(cell, row, column)
  case cell.alive
  when true
  if total == 2 || total == 3
  @cells_that_should_live << cell
  else
  @cells_that_should_die << cell
  end
  when false
  if total >= 3
  @cells_that_should_live << cell
  else
  @cells_that_should_die << cell
  end
  end
  end
  def kill_doomed_cells
  @cells_that_should_die.each do |cell|
  cell.die
  end
  @cells_that_should_die.clear
end
 
def resurrect_lucky_cells
  @cells_that_should_live.each do |cell|
  cell.resurrect
  end
  @cells_that_should_live.clear
end
 
def move_to_next_generation
  kill_doomed_cells
  resurrect_lucky_cells
end
 
def print_world
  system 'clear'
  @cells.each do |ary|
  ary.each do |cell|
  if cell.alive == true
  print "O "
  else
  print "- "
  end
  end
  print "\n"
  end
end
 
def play_game
  birth_random_cells
  print_world
  sleep(1)
  while 1 < 2
  locate_cells_and_neighbors
  move_to_next_generation
  print_world
  sleep(1)
  end
end
 
def birth_random_cells
  lottery = rand(0..99)
  lottery.times do
  row = rand(0..9)
  col = rand(0..9)
  @cells[row][col].resurrect
  end
end
 
end
 
 
class Cell
  attr_accessor :alive # => attr_reader
   
  def initialize
  self.alive = false # => @alive = false
  end
   
  def resurrect
  self.alive = true # => @alive = true
  end
   
  def die
  self.alive = false # => @alive = false
  end
 
end
 
World.new
