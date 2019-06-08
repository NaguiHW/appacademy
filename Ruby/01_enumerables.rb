module Enumerable
    def my_each
        return self unless block_given?
        count = 0
        while count < self.length
            yield(self[count])
            count += 1
        end
        self
    end

    def my_select
        return self unless block_given?
        count = 0
        aux = []
        while count < self.length
            aux << self[count] if yield(self[count])
            count += 1
        end
        aux
    end
end

arr = [1, 2, 3, 4, 5]

arr.select { |x| p x > 2 }
p "--- this is a line ---"
arr.my_select { |x| p x > 2 }