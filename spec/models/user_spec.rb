require 'rails_helper'

RSpec.describe User do
  context 'When saving' do
    it 'transform email to lower case' do
      john = create(:user, email: 'TESTING@TEST.COM')
      expect(john.email).to eq 'testing@test.com'
    end
  end

  describe 'association' do
    it { is_expected.to have_many(:recipes) }
    it { is_expected.to have_many(:ingredients) }
    it { is_expected.to have_many(:instructions) }

    describe 'dependency' do
      let(:recipes_count) { 1 }
      let(:ingredients_count) { 1 }
      let(:instructions_count) { 1 }
      let(:user) { create(:user) }

      it 'destroys recipes' do
        create_list(:recipe, recipes_count, user: user)
        expect { user.destroy }.to change { Recipe.count }.by(-recipes_count)
      end
      it 'destroys ingredients' do
        create_list(:ingredient, ingredients_count, user: user)
        expect { user.destroy }.to change { Ingredient.count }.by(-ingredients_count)
      end
      it 'destroys instructions' do
        create_list(:instruction, instructions_count, user: user)
        expect { user.destroy }.to change { Instruction.count }.by(-ingredients_count)
      end
    end
  end

  describe 'validation' do
    it { is_expected.to have_secure_password }

    it { is_expected.to validate_presence_of(:handle) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    context ' When matching uniqueness of handle' do
      subject { create(:user) }
      it { is_expected.to validate_uniqueness_of(:handle) }
    end

    context ' When matching uniqueness of email' do
      subject { create(:user) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end

    it { is_expected.to validate_length_of(:handle).is_at_most(User:: MAXIMUM_HANDLE_LENGTH) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(User:: MAXIMUM_FIRST_NAME_LENGTH) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(User:: MAXIMUM_LAST_NAME_LENGTH) }
    it { is_expected.to validate_length_of(:email).is_at_most(User:: MAXIMUM_EMAIL_LENGTH) }
    it { is_expected.to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH) }

    context 'When using invalid email format' do
      it 'is invalid' do
        john = build(:user, email: 'test@invalid')
        expect(john.valid?).to be false
      end
    end
  end
end
