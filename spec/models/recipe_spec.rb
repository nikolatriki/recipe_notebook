require 'rails_helper'

RSpec.describe Recipe do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(Recipe::MINIMUM_TITLE_LENGTH) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
