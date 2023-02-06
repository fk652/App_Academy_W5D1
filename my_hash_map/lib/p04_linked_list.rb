class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next if @prev != nil
    @next.prev = @prev if @next != nil
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    current_node = @head
    until current_node == @tail
      if current_node.key == key
        return current_node.val
      end
      current_node = current_node.next
    end
    nil
  end

  def get_node(key)
    current_node = @head
    until current_node == @tail
      if current_node.key == key
        return current_node
      end
      current_node = current_node.next
    end
    nil
  end

  def include?(key)
    return false if get_node(key) == nil
    true
  end

  def append(key, val)
    node = Node.new(key, val)
    node.prev = @tail.prev
    node.next = @tail
    @tail.prev.next = node
    @tail.prev = node
    node
  end

  def update(key, val)
    result = get_node(key)
    result.val = val if result != nil
  end

  def remove(key)
    result = get_node(key)
    result.remove if result != nil
  end

  def each(&prc)
    current_node = @head
    until current_node == last
      current_node = current_node.next
      prc.call(current_node)
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
