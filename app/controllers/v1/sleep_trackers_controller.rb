module V1
  class SleepTrackersController < ApplicationController

    def index
      @pagy, @sleep_trackers = pagy(fetch_data)
      options = { meta: { pagy: pagy_metadata(@pagy) } }

      success_response(SleepTrackerSerializer.new(@sleep_trackers, options).serializable_hash, :ok)
    end

    private

    def fetch_data
      SleepTracker.all.order(created_at: :desc)
    end
  end
  
end