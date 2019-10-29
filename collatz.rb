# collatz.rb
# Written by Gregory Eglen

# Goal: Find the input that produces the longest chain of Collatz values from 1 to 1,000,000.
# Collatz Sequence:
# Given an input of 'n', the next number in is defined by:
#   n -> n/2 (if n is even)
#   n -> 3n + 1 (if n is odd)
# Sequence continues until n is equal to 1


# I wrote this solution on my own:

def find_longest_collatz_chain(n)
  longest_chain = 0
  while n <= 1000000
    number = n
    count = 1
    if number == 1
      number += 1
    end
    while number > 1
      if number % 2 == 0
        number = number/2
        count += 1
      else
        number = 3 * number + 1
        count += 1
      end
    end
    n += 1
    if n % 100000 == 0
    end
    if count > longest_chain
      longest_chain = count
    end
  end
end

# I adapted this solution from C++ code at: https://www.mathblog.dk/project-euler-14/
 
def cache_largest_collatz_chain
  number = 1000000
  sequence_length = 0
  starting_number = 0
  sequence = 0
  cache = Array.new(number + 1, -1)
  cache[1] = 1
  i = 2
  while i <= number
    sequence = i
    k = 0
    while sequence!= 1 && sequence >= i
      k += 1
      if sequence % 2 == 0
        sequence = sequence / 2
      else
        sequence = sequence * 3 + 1
      end
    end
    cache[i] = k + cache[sequence]
    if cache[i] > sequence_length
      sequence_length = cache[i]
      starting_number = i
    end
    i += 1
  end
end

require 'benchmark'
num = 1
Benchmark.bm do |x|
  x.report("find_longest_collatz_chain") { find_longest_collatz_chain(num) }
  x.report("cache_largest_collatz_chain") { cache_largest_collatz_chain }
end 