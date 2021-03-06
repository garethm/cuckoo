require 'spec_helper'

module Cuckoo
  describe Cuckoo do
    describe :add do
      it "add inserts an item with a new key into the table" do
        table = Cuckoo.new
        table.add "john", "abc"
        table.find("john").should == "abc"
      end

      it "stores the first item added" do
        table = Cuckoo.new
        table.add "john", "abc"
        table.add "steve", "qrs"
        table.find("john").should == "abc"
      end

      it "stores the second item added" do
        table = Cuckoo.new
        table.add "john", "abc"
        table.add "steve", "qrs"
        table.find("steve").should == "qrs"
      end

      it "raises an exception if an existing key reused" do
        table = Cuckoo.new
        table.add "john", "abc"
        expect { table.add "john", "qrs" }.to raise_error
      end

      it "can store 13 values" do
        table = Cuckoo.new
        table.add "ella", "mansfield"
        table.add "joan", "sutherland"
        table.add "livy", "pisapio"
        table.add "lorry", "prince"
        table.add "mariejeanne", "spofford"
        table.add "rori", "machado"
        table.add "leena", "kornhaber"
        table.add "fidelia", "clark"
        table.add "marget", "hayford"
        table.add "kerry", "white"
        table.add "abra", "washienko"
        table.add "carmencita", "bratko"
        table.add "gui", "schwertfeger"
        table.add "buffy", "rish"
      end
    end

    describe :find do
      it "returns the value that was added for the specified key" do
        table = Cuckoo.new
        table.add "pete", "rrr"
        table.find("pete").should == "rrr"
      end

      it "returns null if the key was never added" do
        table = Cuckoo.new
        table.find("jojo").should == nil
      end
    end
  end
end