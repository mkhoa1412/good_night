class ClockTime

  TIME_FORMAT = '%FT%T%:z'
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
    hours = (to_time - other.to_time).to_i
    hours.zero? ? hours : hours / 3600
  end
end
