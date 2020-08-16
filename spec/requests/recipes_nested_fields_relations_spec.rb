require 'rails_helper'

RSpec.describe 'RecipesNestedFieldsRelations' do
  describe 'GET recipes ingredients' do
    let(:expected_ingredients_substance) { 'Ingredients substance' }
    let(:ingredient) { create(:ingredient, substance: expected_ingredients_substance) }

    it 'shows the recipe ingredients' do
      get recipe_path(ingredient.recipe)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include expected_ingredients_substance
    end
  end

  describe 'GET recipes instructions' do
    let(:expected_instructions_step) { 'Instructions step' }
    let(:instruction) { create(:instruction, step: expected_instructions_step) }

    it 'shows the recipe instructions' do
      get recipe_path(instruction.recipe)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include expected_instructions_step
    end
  end
end
