# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(handle: 'Chef_One', first_name: 'John', last_name: 'Doe', email: 'john@john.com', password: 'hohoho', password_confirmation: 'hohoho')
User.create(handle: 'Chef_Two', first_name: 'James', last_name: 'Dean', email: 'james@james.com', password: 'hahaha', password_confirmation: 'hahaha')

User.all.each do |user|
  2.times do
    recipe = user.recipes.create(
      title: 'Homemade Pizza Sauce',
      description: "This is my new and improved version. And by 'new and improved,' I mean 'old and secret.' Here is my top-secret formula. The next time you're making homemade pizza, you might as well make some sauce too."
    )
    recipe.ingredients.create([
                                { substance: '2 tablespoons olive oil' },
                                { substance: '2 anchovy fillets' },
                                { substance: '3 cloves garlic, minced' },
                                { substance: '2 tablespoons finely chopped fresh oregano leaves' },
                                { substance: '1/2 teaspoon red pepper flakes' },
                                { substance: '1/2 teaspoon dried oregano' },
                                { substance: '1 (28 ounce) can whole peeled tomatoes (preferably San Marzano), crushed' },
                                { substance: 'salt to taste' }
                                ])
    recipe.instructions.create([
                                  { step: 'Heat olive oil over medium-low heat in a saucepan; stir anchovy fillets into olive oil and cook, stirring often, until the fillets begin to sizzle, about 1 minute. Mix garlic into oil and cook just until fragrant, 1 minute more. Add fresh oregano and reduce heat to low; cook until oregano is wilted, 2 or 3 more minutes.' },
                                  { step: 'Mix red pepper flakes, dried oregano, and tomatoes into olive oil mixture. Bring sauce to a simmer and season with salt, sugar, and black pepper. Turn heat to low; simmer sauce until thickened and oil rises to the top, 35 to 40 minutes, stirring occasionally.' },
                                  { step: 'Stir baking soda into pizza sauce, mixing until thoroughly combined.' },
                                ])
  end
end

puts 'Done!'
