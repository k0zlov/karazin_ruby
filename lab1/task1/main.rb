def word_stats(text)
  words = text.split
  word_count = words.length
  longest_word = words.max_by(&:length)
  unique_count = words.map(&:downcase).uniq.length

  puts "Words: #{word_count}"
  puts "Longest word: #{longest_word}"
  puts "Unique words: #{unique_count}"
end

puts "Enter text:"
text = gets.chomp
word_stats(text)