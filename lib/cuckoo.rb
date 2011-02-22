module Cuckoo
  class Cuckoo
    def initialize
      @size = 13
      @store = Array.new @size
    end

    def djb_hash str
      hash = 5381
      str.bytes.each do |b|
        hash = ((hash << 5) + hash) + b
      end
      hash % @size
    end

    def add key, value
      hash = djb_hash key
      entry = @store[hash]
      raise "Already defined" if entry != nil && entry[0] == key
      raise "Hash slot taken" if entry != nil && entry[0] != key
      @store[hash] = [key, value]
    end

    def find key
      entry = @store[djb_hash key]
      return nil if entry == nil
      entry[1]
    end
  end
end