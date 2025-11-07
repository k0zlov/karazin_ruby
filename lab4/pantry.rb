# frozen_string_literal: true

require_relative 'unit_converter'

class Pantry
  def initialize
    @storage = {}
  end

  def add(name, qty, unit)
    base_qty = UnitConverter.to_base(qty, unit)
    base_unit = UnitConverter::BASE_UNITS[UnitConverter::UNIT_TYPES[unit]]

    @storage[name] ||= { qty: 0, unit: base_unit }
    @storage[name][:qty] += base_qty
  end

  def available_for(name)
    @storage[name] || { qty: 0, unit: nil }
  end
end