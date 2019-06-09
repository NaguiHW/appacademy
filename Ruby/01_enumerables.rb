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
    return combination(1).to_a if n.count.zero?

    counter = 0
    arr = combination(1).to_a
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

  def my_rotate(*n)
    arr = self
    if n.empty?
      rotate_once arr
    else
      number = n[0].to_i
      count = 0
      if number.negative?
        while count > number
          rotate_once_negative arr
          count -= 1
        end
      else
        while count < number
          rotate_once arr
          count += 1
        end
      end
    end
    arr
  end

  def my_join(*n)
    text = ''
    count = 0
    if n.empty?
      while count < length
        text += self[count]
        count += 1
      end
      text
    else
      while count < length
        text += self[count] + n[0].to_s
        count += 1
      end
      text.slice!(0...-1)
    end
  end

  def my_reverse
    count = -1
    arr = []
    while count >= -1 * length
      arr << self[count]
      count -= 1
    end
    arr
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

  def rotate_once(arr)
    aux = arr.shift
    arr << aux
    arr
  end

  def rotate_once_negative(arr)
    aux = arr.pop
    arr.unshift(aux)
    arr
  end
end
