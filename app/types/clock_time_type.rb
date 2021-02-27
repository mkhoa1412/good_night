class ClockTimeType < ActiveRecord::Type::String
  def cast(value)
    return nil unless value.present?
    ClockTime.new(value)
  end

  def deserialize(value)
    cast(value)
  end

  def serialize(value)
    value.to_s
  end
end
