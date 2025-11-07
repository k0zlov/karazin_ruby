# frozen_string_literal: true

require_relative 'unit_converter'

class Recipe
  attr_reader :name, :steps, :items

  def initialize(name, steps, items)
    @name = name
    @steps = steps
    @items = items
  end

  def need
    needs = {}
    @items.each do |item|
      ingredient = item[:ingredient]
      qty = item[:qty]
      unit = item[:unit]

      base_qty = UnitConverter.to_base(qty, unit)
      base_unit = ingredient.unit

      needs[ingredient.name] ||= { qty: 0, unit: base_unit }
      needs[ingredient.name][:qty] += base_qty
    end
    needs
  end
end