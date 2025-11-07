# frozen_string_literal: true

def cut_cake(cake)
  return [] if cake.empty?

  rows = cake.split("\n").map(&:strip)
  height = rows.length
  width = rows[0].length

  raisins = []
  rows.each_with_index do |row, r|
    row.chars.each_with_index do |char, c|
      raisins << [r, c] if char == 'o'
    end
  end

  n = raisins.length

  if n == 0 || n > 10
    puts "Quantity of raisins must be between 1 and 10."
    return []
  end

  area = height * width
  piece_area = area / n

  if area % n != 0
    puts "The area of the cake must be divisible by the quantity of raisins."
    return []
  end

  used = Array.new(height) { Array.new(width, false) }
  pieces = []

  best_solution = nil
  best_width = 0

  solve = lambda do |r_idx|
    if r_idx == n
      first_piece = pieces[0]
      first_width = first_piece[0].length
      if best_solution.nil? || first_width > best_width
        best_width = first_width
        best_solution = pieces.map(&:dup)
      end
      return
    end

    raisin = raisins[r_idx]
    return if used[raisin[0]][raisin[1]]

    (1..height).each do |h|
      (1..width).each do |w|
        next if h * w != piece_area

        (0..height - h).each do |top|
          (0..width - w).each do |left|
            next unless raisin[0] >= top && raisin[0] < top + h
            next unless raisin[1] >= left && raisin[1] < left + w

            valid = true
            raisin_count = 0

            (top...top + h).each do |i|
              (left...left + w).each do |j|
                if used[i][j]
                  valid = false
                  break
                end
                raisin_count += 1 if rows[i][j] == 'o'
              end
              break unless valid
            end

            if valid && raisin_count == 1
              piece_rows = []
              (top...top + h).each do |i|
                piece_rows << rows[i][left...left + w]
                (left...left + w).each { |j| used[i][j] = true }
              end

              pieces << piece_rows
              solve.call(r_idx + 1)
              pieces.pop

              (top...top + h).each do |i|
                (left...left + w).each { |j| used[i][j] = false }
              end
            end
          end
        end
      end
    end
  end

  solve.call(0)

  return [] if best_solution.nil?

  best_solution.map { |piece| piece.join("\n") }
end

cake = ".o.o....
........
....o...
........
.....o..
........"

result = cut_cake(cake)
puts "Result:"

if result.empty?
  puts "No solution."
else
  result.each_with_index do |piece, i|
    puts "Piece #{i + 1}:"
    puts piece
    puts
  end
end