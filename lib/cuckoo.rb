module Cuckoo
  class Cuckoo
    def initialize
      @size = 13
      @store = Array.new @size
      @hash_params1 = {:seed => 5381, :shift => 5}
      @hash_params2 = {:seed => 5381, :shift => 5}
    end

    def djb_hash hash_params, str
      hash = hash_params[:seed]
      str.bytes.each do |b|
        hash = (((hash << hash_params[:shift]) + hash) + b) % 4294967296
      end
      hash % @size
    end

    def add key, value
      hash = djb_hash @hash_params1, key
      entry = @store[hash]
      raise "Already defined" if entry != nil && entry[0] == key
      raise "Hash slot taken" if entry != nil && entry[0] != key
      @store[hash] = [key, value]
    end

    def find key
      hash = djb_hash @hash_params1, key
      entry = @store[hash]
      return entry[1] if entry != nil && entry[0] == key
      nil
    end
  end
end