require 'rails_helper'

RSpec.describe Recipe do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(Recipe::MINIMUM_TITLE_LENGTH) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'association' do
    it { is_expected.to have_many(:ingredients) }
    it { is_expected.to have_many(:instructions) }
    # it { is_expected.to belong_to(:user)}
    it { should accept_nested_attributes_for(:ingredients).allow_destroy(true) }
    it { should accept_nested_attributes_for(:instructions).allow_destroy(true) }
  end

  describe 'dependency' do
    let(:recipe) { create(:recipe) }

    it 'destroys ingredients' do
      create_list(:ingredient, 1, recipe: recipe)
      expect { recipe.destroy }.to change { Ingredient.count }.by(-1)
    end

    it 'destroys instructions' do
      create_list(:instruction, 1, recipe: recipe)
      expect { recipe.destroy }.to change { Instruction.count }.by(-1)
    end
  end
end
