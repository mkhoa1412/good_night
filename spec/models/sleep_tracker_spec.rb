require 'rails_helper'

RSpec.describe SleepTracker, type: :model do
  it 'is valid with clocked_in and clocked_out' do
    time_in = '2021-02-27 11:00:00'
    time_out = '2021-02-28 06:00:00'
    it = build_stubbed(:sleep_tracker, clocked_in: time_in, clocked_out: time_out)
    expect(it).to be_valid
  end

  it 'return default value without clocked_in' do
    it = SleepTracker.new
    it.valid?
    expect(it).to be_valid
    expect(it.clocked_in).to be_present
  end

  it 'is invalid when clocked_in greater than clocked_out' do
    time_in = '2021-02-27 11:00:00'
    time_out = '2021-02-27 06:00:00'
    it = build_stubbed(:sleep_tracker, clocked_in: time_in, clocked_out: time_out)
    it.valid?
    expect(it.errors).to have_key(:clocked_out)
  end

  it 'return right time wit full string time format' do
    time = '2021-02-27 11:00:00'
    it = build_stubbed(:sleep_tracker, clocked_in: time)
    expect(it.clocked_in.to_s).to eq(Time.parse(time).strftime(ClockTime::TIME_FORMAT))
  end

  it 'return right time wit short string time format' do
    time = '11:00'
    it = build_stubbed(:sleep_tracker, clocked_in: time)
    expect(it.clocked_in.to_s).to eq(Time.parse(time).strftime(ClockTime::TIME_FORMAT))
  end

  it 'display sleeping time as string without clocked_out' do
    it = build_stubbed(:sleep_tracker, clocked_in: Time.current)
    expect(it.sleeping_time_str).to eq('00:00:00')
  end

  it 'display sleeping time as string with clocked_out' do
    time = Time.current
    h_interval = rand(24)
    m_interval = rand(60)
    it = create(:sleep_tracker, clocked_in: time, clocked_out: time + h_interval.hours + m_interval.minutes)
    expect(it.sleeping_time_str).to eq(format('%02d:%02d:%02d', h_interval, m_interval, 0))
  end
end
