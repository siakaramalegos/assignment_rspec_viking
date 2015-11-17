require_relative '../lib/viking.rb'
require_relative '../lib/weapons/bow.rb'

describe Viking do

  let(:viking){ Viking.new }
  let(:viking2){ Viking.new}
  let(:bow){ Bow.new }

  describe '#initialize' do

    it 'sets a name if passed to it on creation' do
      my_viking = Viking.new('Sven')
      expect(my_viking.name).to eq('Sven')
    end

    it 'passes a health attribute if given on creation' do
      my_viking = Viking.new('Sven', 138)
      expect(my_viking.health).to eq(138)
    end

    it 'does not allow overwriting health after initialization' do
      expect{viking.health = 200}.to raise_error(NoMethodError)
    end

    it 'default sets a weapon to nil' do
      expect(viking.weapon).to eq(nil)
    end
  end

  describe '#pick_up_weapon' do

    it "sets it as the Viking's weapon" do
      viking.pick_up_weapon(bow)
      expect(viking.weapon).to eq(bow)
    end

    it 'raises an exception when picking up a non-weapon' do
      expect{viking.pick_up_weapon(viking2)}.to raise_error("Can't pick up that thing")
    end

    it 'replaces an existing weapon' do
      viking.pick_up_weapon(bow)
      bow2 = Bow.new
      viking.pick_up_weapon(bow2)
      expect(viking.weapon).to eq(bow2)
    end
  end

  describe '#drop_weapon' do

    it 'leaves the viking weaponless' do
      viking.pick_up_weapon(bow)
      viking.drop_weapon
      expect(viking.weapon).to eq(nil)
    end
  end

  describe '#receive_attack' do

    it "reduces that viking's health by the specified amount" do
      viking.receive_attack(42)
      expect(viking.health).to eq(58)
    end

    it 'calls the take_damage method' do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(42)
    end
  end

  describe '#attack' do

    it "reduces the recipient's health" do
      health = viking2.health
      viking.attack(viking2)
      expect(viking2.health).to be < health
    end

    it "calls the recipient's take_damage method" do
      expect(viking2).to receive(:take_damage)
      viking.attack(viking2)
    end

    it 'raises an error if viking is killed' do
      my_viking = Viking.new('Sven', 2)
      expect{viking.attack(my_viking)}.to raise_error("#{my_viking.name} has Died...")
    end

    context 'attacker has no weapon' do

      it "runs damage_with_fists" do
        allow(viking).to receive(:damage_with_fists).and_return(42)
        expect(viking).to receive(:damage_with_fists)
        viking.attack(viking2)
      end

      it 'deals Fists multiplier times strength damage' do
        health = viking2.health
        viking.attack(viking2)
        expect(viking2.health).to eq(health - 0.25 * viking.strength)
      end
    end

    context 'attacker has a weapon' do
      it "runs damage_with_weapon" do
        viking.pick_up_weapon(bow)
        allow(viking).to receive(:damage_with_weapon).and_return(42)
        expect(viking).to receive(:damage_with_weapon)
        viking.attack(viking2)
      end

      it "deals damage equal to the Viking's strength times that Weapon's multiplier" do
        viking.pick_up_weapon(bow)
        health = viking2.health
        viking.attack(viking2)
        expect(viking2.health).to eq(health - 2 * viking.strength)
      end
    end

    context 'attacker has a bow without enough arrows' do
      it 'uses fists instead' do
        viking.pick_up_weapon(bow)
        10.times{bow.use}
        allow(viking).to receive(:damage_with_fists).and_return(42)
        expect(viking).to receive(:damage_with_fists)
        viking.attack(viking2)
      end
    end
  end
end