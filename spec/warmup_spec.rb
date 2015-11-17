require_relative '../lib/warmup.rb'

describe Warmup do

  let(:warmup){ Warmup.new }

  describe '#gets_shout' do

    it 'should receive gets' do
      allow(warmup).to receive(:gets).and_return("sia\n")
      expect(warmup).to receive(:gets)
      warmup.gets_shout
    end

    it 'should receive puts' do
      allow(warmup).to receive(:gets).and_return("sia\n")
      expect(warmup).to receive(:puts)
      warmup.gets_shout
    end

    it 'should return a shout' do
      allow(warmup).to receive(:gets).and_return("sia\n")
      expect(warmup.gets_shout).to eq("SIA")
    end
  end

  describe '#triple_size' do

    it 'should return triple the size of some array' do
      my_array = double("Array", size: 4)
      expect(warmup.triple_size(my_array)).to eq(12)
      warmup.triple_size(my_array)
    end
  end

  describe '#calls_some_methods' do

    it 'should receive an upcase! method' do
      my_string = double(upcase!: "HI")
      expect(my_string).to receive(:upcase!)
      warmup.calls_some_methods(my_string)
    end

    it 'should receive a reverse! method' do
      my_other_string = double(reverse!: "IH")
      my_string = double(upcase!: my_other_string)

      expect(my_other_string).to receive(:reverse!)
      warmup.calls_some_methods(my_string)
    end

    it 'should return an unrelated string' do
      expect(warmup.calls_some_methods('hi')).to eq('I am unrelated')
    end

  end
end