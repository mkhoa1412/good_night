module Api
  module V1
    class SleepTrackingsController < ApplicationController
    
      def clock_in_operation
        @pagy, @records = pagy(SleepTracking.clock_in_operation)

        render json: {
          pagy: @pagy,
          clock_in_operation: @records
        }, status: :ok
      end
    end
  end
end
