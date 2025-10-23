class FileBatchEnumerator
  def initialize(file_path, batch_size)
    @file_path = file_path
    @batch_size = batch_size
    raise ArgumentError, "Розмір батчу має бути > 0" if @batch_size <= 0
  end

  def batches
    Enumerator.new do |yielder|
      File.open(@file_path, 'r') do |file|
        batch = []
        file.each_line do |line|
          batch << line.chomp

          if batch.size >= @batch_size
            yielder << batch
            batch = []
          end
        end

        yielder << batch unless batch.empty?
      end
    end
  end
end

# --- Приклад використання ---

file_content = (1..25).map { |i| "Рядок #{i}\n" }.join
File.write('test_file.txt', file_content)

batch_reader = FileBatchEnumerator.new('test_file.txt', 10)

iterator = batch_reader.batches

puts "--- Використання як ЗОВНІШНЬОГО ітератора (тягнемо дані) ---"
begin
  puts "Беремо 1-й батч (10 рядків):"
  p iterator.next.size #=> 10

  puts "Беремо 2-й батч (10 рядків):"
  p iterator.next.size #=> 10

  puts "Беремо 3-й батч (останні 5 рядків):"
  p iterator.next.size #=> 5

  puts "Беремо ще один (має бути помилка):"
  iterator.next
rescue StopIteration
  puts "Ітератор успішно закінчився (StopIteration)."
end

puts "\n--- Використання як ВНУТРІШНЬОГО ітератора (.each) ---"
batch_reader.batches.each_with_index do |batch, index|
  puts "Оброблено Батч ##{index + 1} (розмір: #{batch.size})"
end