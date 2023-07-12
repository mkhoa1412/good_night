class SleepTrackingSerializer
  include JSONAPI::Serializer

  attribute :sleep_time
  attribute :wake_up_time
  attribute :sleep_duration
end
