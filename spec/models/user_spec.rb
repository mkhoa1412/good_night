require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = create(:user)
  end

  it 'all clocked_in time ordered by created at desc' do
    @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-01 09:00 PM',
                                                      clocked_out: '2021-02-02 06:00 AM'))
    @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-02 09:00 PM',
                                                      clocked_out: '2021-02-03 06:00 AM'))
    @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-03 09:00 PM',
                                                      clocked_out: '2021-02-04 06:00 AM'))
    @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-04 09:00 PM',
                                                      clocked_out: '2021-02-05 06:00 AM'))
    @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-05 09:00 PM',
                                                      clocked_out: '2021-02-06 06:00 AM'))
    @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-06 09:00 PM',
                                                      clocked_out: '2021-02-07 06:00 AM'))
    @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-07 09:00 PM',
                                                      clocked_out: '2021-02-08 06:00 AM'))
    @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-09 09:00 PM'))

    list = @user.fetch_all_clocked_in
    expect(list.size).to eq(8)
    expect(list.first).to eq(Time.new(2021, 2, 9, 21, 0, 0).strftime(ClockTime::TIME_FORMAT))
    expect(list.last).to eq(Time.new(2021, 2, 1, 21, 0, 0).strftime(ClockTime::TIME_FORMAT))
  end

  it 'follow' do
    @user2 = create(:user)
    @user.follow(@user2)

    expect(@user.followees).to eq([@user2])
    expect(@user2.followers).to eq([@user])
  end

  it 'unfllow' do
    @user2 = create(:user)
    @user3 = create(:user)
    @user.followees << [@user2, @user3]
    @user.unfollow(@user2)

    expect(@user.followees).to eq([@user3])
    expect(@user2.followers).to eq([])
    expect(@user3.followers).to eq([@user])
  end

  it 'sleep_records_last_week_of_followees' do
    @user2 = create(:user)
    @user3 = create(:user)
    @user.follow(@user2)
    @user.follow(@user3)

    last_week = 7.days.ago
    @user2.add_sleeping_tracked(create(:sleep_tracker, clocked_in: last_week - 1.day,
                                                       clocked_out: last_week - 1.day + 7.hour))
    @user2.add_sleeping_tracked(create(:sleep_tracker, clocked_in: last_week, clocked_out: last_week + 6.hour))
    @user3.add_sleeping_tracked(create(:sleep_tracker, clocked_in: last_week + 1.day,
                                                       clocked_out: last_week + 1.day + 9.hour))

    result = @user.sleep_records_last_week_of_followees
    expect(result).to eq(['09:00:00', '06:00:00'])
  end
end
