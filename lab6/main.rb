# frozen_string_literal: true

def curry3(proc_or_lambda)
  accumulated = []

  builder = lambda do |acc|
    lambda do |*args|
      raise ArgumentError, "Too many arguments" if acc.length + args.length > 3

      new_acc = acc + args

      if new_acc.length == 3
        proc_or_lambda.call(*new_acc)
      elsif new_acc.length < 3
        builder.call(new_acc)
      else
        builder.call(acc)
      end
    end
  end

  builder.call(accumulated)
end

sum3 = ->(a, b, c) { a + b + c }

cur = curry3(sum3)

puts "Test 1: cur.call(1).call(2).call(3)"
puts cur.call(1).call(2).call(3)

puts "\nTest 2: cur.call(1, 2).call(3)"
puts cur.call(1, 2).call(3)

puts "\nTest 3: cur.call(1).call(2, 3)"
puts cur.call(1).call(2, 3)

puts "\nTest 4: cur.call(1, 2, 3)"
puts cur.call(1, 2, 3)

puts "\nTest 5: String lambda"
f = ->(a, b, c) { "#{a}-#{b}-#{c}" }
cF = curry3(f)
puts cF.call('A').call('B', 'C')

puts "\nTest 6: Too many arguments"
begin
  cur.call(1, 2, 3, 4)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end

puts "\nTest 7: Pending call"
pending = cur.call()
puts "Result: #{pending.call(1, 2, 3)}"