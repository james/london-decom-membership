require 'rails_helper'

class DummyClass
end

RSpec.describe TimeAsWords do
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(TimeAsWords)
  end

  it 'should convert 12:00 to midday' do
    words = @dummy_class.time_as_words('12:00')
    expect(words).to eq('midday')
  end

  it 'should convert 00:00 to midnight' do
    words = @dummy_class.time_as_words('00:00')
    expect(words).to eq('midnight')
  end

  it 'should convert 18:42 to fourty-two minutes past six in the evening' do
    words = @dummy_class.time_as_words('18:42')
    expect(words).to eq('fourty-two minutes past six in the evening')
  end

  it 'should convert 07:22 to twenty-two minutes past seven in the morning' do
    words = @dummy_class.time_as_words('07:22')
    expect(words).to eq('twenty-two minutes past seven in the morning')
  end

  it 'should convert 17:10 to ten minutes past five in the afternoon' do
    words = @dummy_class.time_as_words('17:10')
    expect(words).to eq('ten minutes past five in the afternoon')
  end

  it 'should convert 13:56 to fifty-six minutes past one in the afternoon' do
    words = @dummy_class.time_as_words('13:56')
    expect(words).to eq('fifty-six minutes past one in the afternoon')
  end

  it 'should return the given value as it is not a time' do
    words = @dummy_class.time_as_words('testing')
    expect(words).to eq('testing')
  end
end
