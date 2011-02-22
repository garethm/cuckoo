module Cuckoo
  class Cuckoo
    def initialize
      @size = 13
      @store = Array.new @size
      @hash1 = method(:djb_hash)
      @hash2 = method(:bkdr_hash)
    end

    def djb_hash str
      hash = 5381
      str.bytes.each do |b|
        hash = (((hash << 5) + hash) + b) % 4294967296
      end
      hash % @size
    end

    def bkdr_hash str
      seed = 31
      hash = 0
      str.bytes.each do |b|
        hash = (hash * seed + b) % 4294967296
      end
      hash % @size
    end

    def add_cuckoo key, value, key_history
      print "  Attempting to add #{key}\n"

      hash1 = @hash1.call key
      entry1 = @store[hash1]
      hash2 = @hash2.call key
      entry2 = @store[hash2]

      raise "Already defined" if entry1 != nil && entry1[0] == key
      raise "Already defined" if entry2 != nil && entry2[0] == key
      
      if entry1 == nil then
        @store[hash1] = [key, value]
      elsif entry2 == nil then
        @store[hash2] = [key, value]
      elsif not key_history.include? entry1[0]
        @store[hash1] = [key, value]
        key_history << entry1[0]
        add_cuckoo entry1[0], entry1[1], key_history
      elsif not key_history.include? entry2[0]
        @store[hash2] = [key, value]
        key_history << entry2[0]
        add_cuckoo entry2[0], entry2[1], key_history
      else
        resize @size * 2 + 1
        add_cuckoo key, value, []
      end
    end

    def resize new_size
      print "  Resizing hash table to #{new_size}\n"
      old_store = @store
      @size = new_size
      @store = Array.new @size
      old_store.each do |entry|
        next if entry == nil
        add_cuckoo entry[0], entry[1], []
      end
      print "  Resize complete\n"
    end

    def add key, value
      print "==============\nadd #{key} => #{value}\n"
      add_cuckoo key, value, []
    end

    def find key
      hash = @hash1.call key
      entry = @store[hash]
      return entry[1] if entry != nil && entry[0] == key
      hash = @hash2.call key
      entry = @store[hash]
      return entry[1] if entry != nil && entry[0] == key
      nil
    end
  end
end