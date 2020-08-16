require 'rails_helper'

RSpec.describe 'Ingredients' do
  let(:recipe) { create(:recipe) }
  let(:ingredient) { create(:ingredient, recipe: recipe) }

  describe 'Edit recipe ingredients' do
    context 'when no user is signed in' do
      it 'redirect back to login path' do
        get edit_recipe_ingredient_path(recipe, ingredient)

        expect(response).to redirect_to(login_path)
      end

      it 'redirect back to login path using patch HTTP verb' do
        patch_params = {
          params: {
            ingredient: {
              substance: 'New substance'
            }
          }
        }

        patch recipe_ingredient_path(recipe, ingredient), patch_params

        expect(response).to redirect_to(login_path)
      end
    end

    context 'when a user is signed in' do
      let(:user) { create(:user) }
      let(:user_ingredient) { create(:ingredient, user: user) }

      before { request_log_in(user) }

      it 'cannot edit different user ingredients' do
        patch_params = {
          params: {
            ingredient: {
              substance: 'New substance'
            }
          }
        }

        patch recipe_ingredient_path(recipe, ingredient), patch_params

        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq 'Wrong user!'
      end

      it 'is able to edit a ingredient' do
        patch_params = {
          params: {
            ingredient: {
              substance: 'MyString'
            }
          }
        }

        patch recipe_ingredient_path(user_ingredient.recipe, user_ingredient), patch_params
        expect(user_ingredient.reload.substance).to eq 'MyString'
      end
    end
  end

  describe 'Creating an recipe ingredient' do
    context 'when no user is signed in' do
      it 'redirects to login' do
        post_params = {
          params: {
            ingredient: {
              substance: 'New substance'
            }
          }
        }

        post recipe_ingredients_path(recipe), post_params

        expect(response).to redirect_to(login_path)
      end
    end

    context 'when a user is sign in' do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }

      before { request_log_in(user) }

      it 'can create a ingredient' do
        post_ingredient_params = {
          params: {
            ingredient: {
              substance: 'New substance'
            }
          }
        }

        expect do
          post recipe_ingredients_path(recipe), post_ingredient_params
        end.to change { Ingredient.count }
      end
    end
  end

  describe 'Deleting an recipe ingredient' do
    context 'when no user is signed in' do
      it 'redirect back when deleting a ingredient' do
        delete recipe_ingredient_path(recipe, ingredient)

        expect(response).to redirect_to(login_path)
      end
    end

    context 'when a user is sign in' do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }
      let(:ingredient) { create(:ingredient, user: user, recipe: recipe) }

      let(:different_user) { create(:user) }
      let(:different_ingredient) { create(:ingredient, user: different_user) }

      before { request_log_in(user) }

      it 'can delete its own recipe ingredient' do
        delete recipe_ingredient_path(recipe, ingredient)

        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'cannot delete different user ingredient on a different user recipe' do
        delete recipe_ingredient_path(recipe, different_ingredient)

        expect(flash[:danger]).to eq 'Wrong user!'
        expect(response).to redirect_to(root_path)
      end

      it 'can delete different user ingredients on its own recipe' do
        recipe.ingredients << different_ingredient

        delete recipe_ingredient_path(recipe, different_ingredient)

        expect(response).to redirect_to(recipe_path(recipe))
      end
    end
  end
end
