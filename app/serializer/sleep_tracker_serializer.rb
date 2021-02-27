class SleepTrackerSerializer 
  include JSONAPI::Serializer

  attributes :id, :clocked_in, :clocked_out

end
