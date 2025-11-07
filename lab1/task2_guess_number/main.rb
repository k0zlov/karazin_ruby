def play_game
  secret_number = rand(1..100)
  attempts = 0

  puts "Guess the number between 1 and 100:"

  loop do
    guess = gets.chomp.to_i
    attempts += 1

    if secret_number > guess
      puts "Higher"
    elsif secret_number < guess
      puts "Lower"
    else
      puts "Correct! You guessed it in #{attempts} attempts"
      break
    end
  end
end

play_game
