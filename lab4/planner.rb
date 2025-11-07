# frozen_string_literal: true

class Planner
  def self.plan(recipes, pantry, price_list, calorie_list)
    all_needs = {}

    recipes.each do |recipe|
      recipe.need.each do |name, data|
        all_needs[name] ||= { qty: 0, unit: data[:unit] }
        all_needs[name][:qty] += data[:qty]
      end
    end

    results = []
    total_calories = 0
    total_cost = 0

    all_needs.each do |name, need_data|
      need_qty = need_data[:qty]
      have_data = pantry.available_for(name)
      have_qty = have_data[:qty]
      deficit_qty = [need_qty - have_qty, 0].max

      price_per_unit = price_list[name] || 0
      calories_per_unit = calorie_list[name] || 0

      cost = need_qty * price_per_unit
      calories = need_qty * calories_per_unit

      total_cost += cost
      total_calories += calories

      results << {
        name: name,
        need: need_qty,
        have: have_qty,
        deficit: deficit_qty,
        unit: need_data[:unit]
      }
    end

    {
      items: results,
      total_calories: total_calories,
      total_cost: total_cost
    }
  end
end