require 'rails_helper'

RSpec.describe "Recipes interactions" do
  let(:recipe) { create(:recipe, user: user) }
  let(:user) { create(:user) }

  before do
    driven_by :rack_test

    visit root_path

    user = create(:user)

    click_on 'Log in'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_on 'submit'
    end
    visit root_path
  end

  describe 'Creating a recipe' do
    it 'creats and shows the newly created recipe' do
      title = 'Create new system spec'
      description = 'This is the description'
      substance = 'This is ingredient'
      step = 'This is instruction step'
      click_on 'New recipe'

      within('form') do
        fill_in 'Title', with: title
        fill_in 'Description', with: description
        fill_in 'recipe_ingredients_attributes_3_substance', with: substance
        fill_in 'recipe_instructions_attributes_3_step', with: step

        click_on 'Create Recipe'
      end

      expect(page).to have_content(title)
      expect(page).to have_content(description)
      expect(page).to have_content(substance)
      expect(page).to have_content(step)
    end
  end

  describe 'Editing a recipe' do
    it 'edits and shows the recipe' do
      title = 'New title'
      description = 'New description'
      substance = 'This is new ingredient'
      step = 'This is new instruction step'
      visit recipe_path(recipe)

      click_on

      within('form') do
        fill_in 'Title', with: title
        fill_in 'Description', with: description
        fill_in 'recipe_ingredients_attributes_3_substance', with: substance
        fill_in 'recipe_instructions_attributes_3_step', with: step

        click_on 'Update recipe'
      end

      expect(page).to have_content(title)
      expect(page).to have_content(description)
    end
  end

  describe 'Deleting a recipe' do
    it 'deletes the recipe' do
      visit recipe_path(recipe)

      find('.icon-margins').click

      expect(page).to have_content('New recipe')
    end
  end

  # describe 'Creating new recipe ingredient' do
  #   it 'creates new ingredient on recipe' do
  #     substance = 'New ingredient substance'

  #     visit recipe_path(recipe)

  #     find('.icon-margins').click_on

  #     within('form') do
  #       fill_in 'Ingredient', with: substance

  #       click_on 'Create ingredient'
  #     end

  #     expect(page).to have_content(substance)
  #   end
  # end
end
