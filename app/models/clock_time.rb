class ClockTime
  TIME_FORMAT = '%FT%T%:z'.freeze
  TIME_COMPONENTS = %i[hours minutes].freeze

  extend Forwardable
  attr_reader :value

  def_delegators :value, :nil?, :present?, :blank?, :hour

  def initialize(value)
    @value = case value
             when Time
               value
             else
               Time.parse(value.to_s)
             end
  end

  def to_time
    value
  end

  def to_s
    value.strftime(TIME_FORMAT)
  end

  def ==(other)
    value.to_time == other.to_time
  end

  def <(other)
    value.to_time < other.to_time
  end

  def >(other)
    value.to_time > other.to_time
  end

  def -(other)
    seconds_diff = (to_time - other.to_time).to_i.abs
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
    seconds = seconds_diff
    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end
end
