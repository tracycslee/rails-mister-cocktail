require 'creek'

puts 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Creating cocktails...'

creek = Creek::Book.new 'cocktail_data.xlsx'
worksheet1 = creek.sheets[0]
worksheet1.rows.each do |row|
  row.map { |key, value| Cocktail.create!(name: value) }
end

ingredients = %w(gin rum vodka whisky tequila champagne cola lemonade cherries
  olives cinnamon lemonade lime mint nutmeg sugar strawberries pineapple)

ingredients.each do |ingredient|
  Ingredient.create!(
    name: ingredient
  )
end

20.times do
  Dose.create!(description: rand(1..10), ingredient: Ingredient.all.sample, cocktail: Cocktail.all.sample)
end
