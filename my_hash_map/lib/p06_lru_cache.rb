require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if !@map.include?(key)
      val = @prc.call(key)
      node = @store.append(key, val)
      @map.set(key, node)
      if @map.count > @max
        eject!
      end
      return node.val
    else
      node = @store.get_node(key)
      new_node = update_node!(node)
      @map.delete(key)
      @map.set(key, new_node)
      return new_node.val
    end

  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @store.append(node.key, node.val)
  end

  def eject!
    node_to_eject = @store.first
    @map.delete(node_to_eject.key)
    node_to_eject.remove
  end
end
