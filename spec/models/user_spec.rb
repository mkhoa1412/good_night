require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = create(:user)
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
  end

  it 'all clocked_in time ordered by created at desc' do
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
end
