class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false) 
    @max = max
  end

  def insert(num)
    raise 'Out of bounds' if num > @max || num < 0
    @store[num] = true
    @store
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    index = num % @store.length
    @store[index] << num
  end

  def remove(num)
    index = num % @store.length 
    @store[index].delete(num)
  end

  def include?(num)
    index = num % @store.length
    @store[index].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      self[num] << num
      @count += 1
      if count == num_buckets - 1
        resize! 
      end
    end

  end

  def remove(num)
    if include?(num)
      self[num].delete(num) 
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(old_store.length * 2) { Array.new }
    @count = 0
    old_store.each do |bucket|
      bucket.each do |item|
        insert(item)
      end
    end

  end

end
