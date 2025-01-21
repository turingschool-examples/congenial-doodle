require "./spec/spec_helper.rb"


RSpec.describe Visitor do
  before(:each) do
    @visitor1 = Visitor.new("Bruce", 54, "$10")
    
  end

  describe "initialize" do
    it "exists" do
      expect(@visitor1).to be_an_instance_of(Visitor)
    end
    it "has a name" do
      expect(@visitor1.name).to eq("Bruce")
    end
    it "has a height" do
      expect(@visitor1.height).to eq(54)
    end
    it "has spending money" do
      expect(@visitor1.spending_money).to eq(10)
    end
    it "has an array for preferences" do
      expect(@visitor1.preferences).to eq([])
    end
  end

  describe "methods" do
    it "can add a preference" do
      @visitor1.add_preference(:gentle)  
      @visitor1.add_preference(:thrilling)
      expect(@visitor1.preferences).to eq([:gentle, :thrilling])
    end
    it "can tell if someone is tall enough" do
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor3 = Visitor.new('Penny', 64, '$15')
      expect(@visitor1.tall_enough?(54)).to eq(true)
      expect(visitor2.tall_enough?(54)).to eq(false)
      expect(visitor3.tall_enough?(54)).to eq(true)
      expect(@visitor1.tall_enough?(64)).to eq(false)
    end
  end
end