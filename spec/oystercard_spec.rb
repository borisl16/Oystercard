require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
  end
    
  describe '#top_up' do
    it 'can top up the balance' do
      expect { subject.top_up(1)}.to change { subject.balance }.by(1)
    end
      
    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error("Maximum balance exceeded")
    end
  end    

  describe '#touch_in / #touch_out / #journey?' do
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }
    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'should touch in' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.journeys.last).to eq(entry_station: entry_station)
    end

    it 'will not touch in if below minimum balance' do
      expect { subject.touch_in(entry_station) }.to raise_error("Insufficient balance to touch in")
    end

    it "can touch out" do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
        
    it 'will deduct money when touch out' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end

    it 'stores exit station' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys.last).to include(exit_station: exit_station)
    end

    # it 'has an empty list of journeys by default' do
    #   expect(subject.journeys).to be_empty
    # end

    # it 'stores a journey' do
    #   subject.top_up(1)
    #   subject.touch_in(entry_station)
    #   subject.touch_out(exit_station)
    #   expect(subject.journeys).to include journey
    # end
  end
end


