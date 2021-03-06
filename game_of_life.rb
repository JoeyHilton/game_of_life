# carlos_conways_game_of_life.rb

# Tasks:
# 01. Display a Matrix of 10 x 10
# 02. Insert random elements into the Matrix (any single digit) and display it
# 03. Ask if user wants a new random matrix and display if user said yes
# 04. Generate a Matrix of max(30) rows x max(100) columns, based on user input
#     With values only being ' ' and '0'
# 05. Test is cells are alive or not ('0' is dead and '1' is alive)
# 06. Apply Rules of Conways game of life - Part 1
#   Count living cells surrounding each element in matrix
# 07. Apply Rules of Conways game of life - Part 2
#   Create new matrix with rules applied, display it and iterate it for 10 times
#   Rules:
#     Any live cell with fewer than two live neighbours dies, as if caused by 
#   under-population.
#     Any live cell with two or three live neighbours lives on to the next generation.
#     Any live cell with more than three live neighbours dies, as if by overcrowding.
#     Any dead cell with exactly three live neighbours becomes a live cell, as if by 
#     reproduction.


# Extra 01. Use n iterations
# Extra 02. Fix menus and presentation
# Extra 03. Let user decide what percentage of board to fill with '0' at the beginning.
# Extra 04. Move classes to files of their own
# require 'matrix'

@alive = "⦿"
@dead = " "
@matrix = Array.new(50) {Array.new(50) {[@alive,@dead].sample}}
# @matrix2 = Array.new(50) {Array.new(50) {" "}}
@matrix2 = @matrix.dup
@matrix3 = Array.new(50) {Array.new(50) {" "}}

def display_matrix(matrix)
  matrix.each do |row|
    puts row.map { |col| col}.join(' ')
  end 
end

# def rand_matrix
  # @matrix = Matrix.build(10) {[@alive,@dead].sample}
  # @matrix = @matrix.to_a
# end
def introduction
  puts "The Game of Life"
  puts ""
  puts "Would you like to generate a new random matrix?"
  response = gets.chomp.downcase.to_s
  if response == "y"
    looper
    # display_matrix
  else
    puts "Too bad, it's really cool."
  end
end

# a = display_matrix
# b = [ ]
# a.map! { |x| x == 1 ? b : x }.flatten!

# a.inspect


# a = [1, 2, 3, 4, 5]
# b = [11, 22, 33, 44]
# a.map! { |x| x == 5 ? b : x }.flatten!

# a = [1, 2, 3, 4, 5]
# a[a.index(5)]=[11, 22, 33, 44] if a.index(5)
# a.flatten!

# puts ""


def find_neighbors(row_index, col_index)
  # neighbors = [
  #   @matrix[row_index - 1 >= 0 ? row_index - 1 : 9] [col_index - 1 >= 0 ? col_index - 1 : 9],
  #   @matrix[row_index - 1 >= 0 ? row_index - 1 : 9] [col_index],
  #   @matrix[row_index - 1 >= 0 ? row_index - 1 : 9] [col_index + 1 < 10 ? col_index + 1 : 0],
  #   @matrix[row_index]                              [col_index - 1 >= 0 ? col_index - 1 : 9],
  #   @matrix[row_index]                              [col_index + 1 < 10 ? col_index + 1 : 0],
  #   @matrix[row_index + 1 < 10 ? row_index + 1 : 0 ][col_index - 1 >= 0 ? col_index - 1 : 9],
  #   @matrix[row_index + 1 < 10 ? row_index + 1 : 0 ][col_index],
  #   @matrix[row_index + 1 < 10 ? row_index + 1 : 0 ][col_index + 1 < 10 ? col_index + 1 : 0]
  # ]
  # return neighbors
    neighbors = [
      @matrix[row_index - 1] [col_index - 1], 
      @matrix[row_index]                             [col_index - 1], 
      @matrix[row_index + 1 < 50 ? row_index + 1 : 0][col_index - 1], 
      @matrix[row_index - 1] [col_index], 
      @matrix[row_index + 1 < 50 ? row_index + 1 : 0][col_index], 
      @matrix[row_index - 1] [col_index + 1 < 50 ? col_index + 1 : 0], 
      @matrix[row_index]                             [col_index + 1 < 50 ? col_index + 1 : 0], 
      @matrix[row_index + 1 < 50 ? row_index + 1 : 0][col_index + 1 < 50 ? col_index + 1 : 0]
    ]

  count_neighbors(neighbors)
end

# introduction
#p find_neighbors(1,1)

def count_neighbors(neighbors)
  count = 0
  neighbors.each do |cell|
    count += 1 if cell == @alive

  end
  return count
end

# p count_neighbors(find_neighbors(0, 0))

# def count_array
#   rand_matrix
#   display_matrix
# end

def rules(x, y, alive_count)

  if @matrix[x][y] == @alive
    if alive_count < 2
       @matrix2[x][y] = @dead
    elsif alive_count == 2 || alive_count == 3
      @matrix2[x][y] = @alive
    elsif alive_count > 3
       @matrix2[x][y] = @dead 
    end
  else 
    if alive_count == 3
      @matrix2[x][y] = @alive
    end
  end
end

def iterator
  @matrix.each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      alive_neighbor_count = find_neighbors(row_index, col_index)
      @matrix3[row_index][col_index] = alive_neighbor_count
      rules(row_index, col_index, alive_neighbor_count)
    end
  end
end

def looper()
  # 2.times do
  while true
    system "clear"

    iterator
    @matrix = @matrix2.dup
    display_matrix(@matrix3)
    display_matrix(@matrix)
    sleep 0.3
  end
end

introduction
# looper()

# def cells_that_should_die
#   if x == 1 && count(0..1) then x = 0 ||
#    x ==1  && count(4..8) then x = 0
# end

# def cells_that_should_live
#   if x == 1 && count(2..3) then x = 0 ||
#     x == 0 && count == 3 then x = 1
# end


# puts count

#   # if x == 1 and n(0..1) then x = 0
#   # if x == 1 and n(2..3) then x = 1
#   # if x== 1 and  n(4..8) then x = 0
#   # if x == 0 and n==3 then x = 1

# x = [0][0]
# n = 0

# rand_matrix.length do |row|
#   rand_matrix.length do |row|

