# require 'creek'

require 'open-uri'

puts 'Cleaning database...'
Dose.delete_all if Rails.env.development?
Ingredient.delete_all if Rails.env.development?
Cocktail.delete_all if Rails.env.development?

url = "https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json"

puts 'Creating cocktails...'


cocktails_array = JSON.parse(open(url).read)


cocktails_array.each do |cocktail|
  c = Cocktail.create!(name: cocktail["name"])
  p "Added #{c.name} to the list"
  cocktail["ingredients"].each do |ing|
    unless ing["ingredient"].nil?
      i = Ingredient.find_or_create_by!(name: ing["ingredient"])
      p "Added #{i.name} to the list"
      Dose.create(description: ing["amount"].to_s + " " + ing["unit"], ingredient: i, cocktail: c )
    end
  end
end

creek = Creek::Book.new 'cocktail_data.xlsx'
worksheet1 = creek.sheets[0]
worksheet1.rows.each do |row|
  row.map { |key, value| Cocktail.create!(name: value) }
end

# cocktails = ["gin & tonic", "tequila sunrise", "old fashioned", "berries mojito", "cosmopolitan"]

# cocktails.each { |name| Cocktail.create!(name: name) }


# ingredients = %w(gin rum vodka whisky tequila champagne cola lemonade cherries
#   olives cinnamon lemonade lime mint nutmeg sugar strawberries pineapple)

# ingredients.each do |ingredient|
#   Ingredient.create!(
#     name: ingredient
#   )
# end

# 20.times do
#   Dose.create!(description: rand(1..10), ingredient: Ingredient.all.sample, cocktail: Cocktail.all.sample)
# end
