# frozen_string_literal: true

class Ingredient
  VALID_UNITS = [:g, :kg, :ml, :l, :pcs].freeze

  attr_reader :name, :unit, :calories_per_unit

  def initialize(name, unit, calories_per_unit)
    raise ArgumentError, "Invalid unit" unless VALID_UNITS.include?(unit)
    @name = name
    @unit = unit
    @calories_per_unit = calories_per_unit
  end
end