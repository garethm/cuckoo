module Cuckoo
  class Cuckoo
    def initialize
      @hash = {}
    end

    def add key, value
      raise "Already defined" if @hash.include? key
      @hash[key] = value
    end

    def find key
      @hash[key]
    end
  end
end