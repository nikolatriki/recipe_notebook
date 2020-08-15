require 'rails_helper'

RSpec.describe "HomePages", type: :system do
  before do
    driven_by(:rack_test)

    visit root_path
  end

  it 'shows the Home link' do
    expect(page.has_link?('recipe_notebook')).to be true
  end

  context 'When no user is signed in' do
    it 'shows the Sign up link' do
      expect(page.has_link?('Sign up')).to be true
    end
    it 'shows the Log in link' do
      expect(page.has_link?('Log in')).to be true
    end
  end

  context 'When user is signed in into the app' do

    before do
      log_in(create(:user))

      visit root_path
    end

    it 'shows the New Recipe link' do
      expecting = page.has_link?('New Recipe')

      expect(expecting).to be true
    end

    it 'shows the Logout link' do
      expecting = page.has_link?('Log out')

      expect(expecting).to be true
    end
  end

  context 'When a recipe is displayed' do
    let!(:recipe) { create(:recipe, title: 'Testing title with Rspec', description: 'Testing body with Rspec')}

    before do
      visit root_path
    end

    it 'shows the recipe title' do
      expect(page.has_content?(recipe.title)).to be true
    end

    it 'shows the recipe description' do
      expect(page.has_content?(recipe.description)).to be true
    end

    it 'shows the link to user' do
      expect(page.has_link?(recipe.user.handle)).to be true
    end

    # it 'shows the link to user' do
    #   expect(page.has_link?(recipe.user.handle)).to be true
    # end
  end
end
