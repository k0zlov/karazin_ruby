# frozen_string_literal: true

module UnitConverter
  CONVERSIONS = {
    kg: { g: 1000 },
    g: { kg: 0.001 },
    l: { ml: 1000 },
    ml: { l: 0.001 },
    pcs: { pcs: 1 }
  }.freeze

  BASE_UNITS = {
    mass: :g,
    volume: :ml,
    count: :pcs
  }.freeze

  UNIT_TYPES = {
    g: :mass,
    kg: :mass,
    ml: :volume,
    l: :volume,
    pcs: :count
  }.freeze

  def self.convert(value, from_unit, to_unit)
    return value if from_unit == to_unit

    from_type = UNIT_TYPES[from_unit]
    to_type = UNIT_TYPES[to_unit]

    raise ArgumentError, "Cannot convert between mass and volume" if from_type != to_type

    if CONVERSIONS[from_unit] && CONVERSIONS[from_unit][to_unit]
      value * CONVERSIONS[from_unit][to_unit]
    else
      raise ArgumentError, "Conversion not supported"
    end
  end

  def self.to_base(value, unit)
    unit_type = UNIT_TYPES[unit]
    base_unit = BASE_UNITS[unit_type]
    convert(value, unit, base_unit)
  end
end