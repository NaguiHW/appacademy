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

  def my_flatten(n = nil)
    n ? multiple_flatten(self, n) : recursive_flatten(self)
  end

  def my_zip(*n)
    return self.combination(1).to_a if n.count == 0
    counter = 0
    arr = self.combination(1).to_a
    items = n.count
    while counter < arr.length
      other_counter = 0
      while other_counter < items
        arr[counter] << n[other_counter][counter]
        other_counter += 1
      end
      counter += 1
    end
    arr
  end

  def my_rotate
  end

  private

  def recursive_flatten(array, results = [])
    array.each do |element|
      if element.class == Array
        recursive_flatten(element, results)
      else
        results << element
      end
    end
    results
  end

  def multiple_flatten(array, n)
    count = 0
    arr = array
    while count < n
      arr = single_flatten(arr)
      count += 1
    end
    arr
  end

  def single_flatten(array)
    results = []
    array.each do |element|
      if element.class == Array
        element.each { |value| results << value }
      else
        results << element
      end
    end
    results
  end
end

arr = [1, 2, 3, 4, 5]
arr2 = [1, 2, 3, [4, [5, 6]], [[[7]], 8]]

p ar = [].to_a
p '=============================='
p ['a', 'b', 'c'].my_zip([1], [1, 2], [1, 2, 3], ['a', 'b', 'c'])
p '=============================='
p ['a', 'b', 'c'].zip([1], [1, 2], [1, 2, 3], ['a', 'b', 'c'])
