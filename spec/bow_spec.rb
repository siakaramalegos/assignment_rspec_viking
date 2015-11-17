require_relative '../lib/weapons/bow.rb'

describe Bow do

  let(:bow){ Bow.new}

  describe '#initialize' do

    it 'should have a readable arrow count' do
      expect(bow.arrows).to be_truthy
    end

    it 'should start with 10 arrows by default' do
      expect(bow.arrows).to eq(10)
    end

    it 'should start with a specified number of arrows if given' do
      bow_20 = Bow.new(20)
      expect(bow_20.arrows).to eq(20)
    end
  end

  describe '#use' do

    it 'reduce arrow count by 1' do
      bow.use
      expect(bow.arrows).to eq(9)
    end

    it 'should throw an error if 0 arrows left before using' do
      10.times{bow.use}
      expect{bow.use}.to raise_error("Out of arrows")
    end
  end

end