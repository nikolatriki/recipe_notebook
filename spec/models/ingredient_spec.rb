require 'rails_helper'

RSpec.describe Ingredient do
  describe 'association' do
    it { is_expected.to belong_to(:recipe)}
    # it { is_expected.to belong_to(:user)}
  end

  describe 'validation' do
    it { should validate_presence_of(:substance) }
  end
end
