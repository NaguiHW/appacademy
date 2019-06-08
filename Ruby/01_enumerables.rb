# frozen_string_literal: true

# simulating the enumerable methods
module Enumerable
  def my_each
    return self unless block_given?

    count = 0
    while count < length
      yield(self[count])
      count += 1
    end
    self
  end

  def my_select
    return self unless block_given?

    count = 0
    aux = []
    while count < length
      aux << self[count] if yield(self[count])
      count += 1
    end
    aux
  end

  def my_reject
    return self unless block_given?

    count = 0
    aux = []
    while count < length
      aux << self[count] unless yield(self[count])
      count += 1
    end
    aux
  end

  def my_any?
    return true unless block_given?

    count = 0
    while count < length
      return true if yield(self[count])

      count += 1
    end
    false
  end
end

arr = [1, 2, 3, 4, 5]

p arr.any? { |x| x > 3 }
p arr.my_any? { |x| x > 3 }
