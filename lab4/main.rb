# frozen_string_literal: true

require_relative 'ingredient'
require_relative 'recipe'
require_relative 'pantry'
require_relative 'planner'

flour = Ingredient.new("flour", :g, 3.64)
milk = Ingredient.new("milk", :ml, 0.06)
egg = Ingredient.new("egg", :pcs, 72)
pasta = Ingredient.new("pasta", :g, 3.5)
sauce = Ingredient.new("sauce", :ml, 0.2)
cheese = Ingredient.new("cheese", :g, 4.0)

pantry = Pantry.new
pantry.add("flour", 1, :kg)
pantry.add("milk", 0.5, :l)
pantry.add("egg", 6, :pcs)
pantry.add("pasta", 300, :g)
pantry.add("cheese", 150, :g)

price_list = {
  "flour" => 0.02,
  "milk" => 0.015,
  "egg" => 6.0,
  "pasta" => 0.03,
  "sauce" => 0.025,
  "cheese" => 0.08
}

calorie_list = {
  "egg" => 72,
  "milk" => 0.06,
  "flour" => 3.64,
  "pasta" => 3.5,
  "sauce" => 0.2,
  "cheese" => 4.0
}

omelet = Recipe.new(
  "Omelet",
  ["Beat eggs", "Add milk and flour", "Fry"],
  [
    { ingredient: egg, qty: 3, unit: :pcs },
    { ingredient: milk, qty: 100, unit: :ml },
    { ingredient: flour, qty: 20, unit: :g }
  ]
)

pasta_recipe = Recipe.new(
  "Pasta",
  ["Boil pasta", "Add sauce and cheese"],
  [
    { ingredient: pasta, qty: 200, unit: :g },
    { ingredient: sauce, qty: 150, unit: :ml },
    { ingredient: cheese, qty: 50, unit: :g }
  ]
)

recipes = [omelet, pasta_recipe]

result = Planner.plan(recipes, pantry, price_list, calorie_list)

puts "Recipe Planning Report"
puts "=" * 60

result[:items].each do |item|
  puts "#{item[:name].capitalize}:"
  puts "  Need: #{item[:need]} #{item[:unit]}"
  puts "  Have: #{item[:have]} #{item[:unit]}"
  puts "  Deficit: #{item[:deficit]} #{item[:unit]}"
  puts
end

puts "=" * 60
puts "Total Calories: #{result[:total_calories].round(2)}"
puts "Total Cost: $#{result[:total_cost].round(2)}"