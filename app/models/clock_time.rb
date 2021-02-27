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

  def to_s
    value.strftime(TIME_FORMAT)
  end

  def ==(other)
    value.to_s == other.to_s
  end

  def -(other)
    hour - other.hour
  end
end
