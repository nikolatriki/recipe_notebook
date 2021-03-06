require 'rails_helper'

RSpec.describe "Recipes" do
  describe 'Creating a recipe' do
    context "when no user is logged in" do
      it 'redirects back to login path' do
        post_params = {
          params: {
            recipe: {
              title: 'New recipe'
            }
          }
        }

        post '/recipes', post_params

        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq 'You must log in first.'
      end
    end
  end

  describe 'Editing a recipe' do
    context "when the recipe's user is the same as the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }

      it 'can edit the recipe' do
        get '/login'
        expect(response).to have_http_status(:ok)

        request_log_in(user)

        follow_redirect!
        expect(flash[:success]).to eq "Welcome #{user.handle} !"

        get "/recipes/#{recipe.id}"
        expect(response).to have_http_status(:ok)

        get "/recipes/#{recipe.id}/edit"
        expect(response).to have_http_status(:ok)

        patch_params = {
          params: {
            recipe: {
              title: recipe.title,
              description: "New description"
            }
          }
        }

        patch "/recipes/#{recipe.id}", patch_params

        expect(response).to have_http_status(:found)

        expect(response).to redirect_to(assigns(:recipe))
        follow_redirect!

        expect(response.body).to include(recipe.title)
      end
    end

    context "when the recipe's user is different then the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }

      let(:login_user) { create(:user) }

      before { request_log_in(login_user) }

      it 'redirect back when GET edit' do
        get "/recipes/#{recipe.id}/edit"

        expect(flash[:danger]).to eq 'Wrong user!'
        expect(response).to redirect_to(root_path)
      end

      it 'redirect back when PATCH edit' do
        patch_params = {
          params: {
            recipe: {
              title: recipe.title,
              description: "New description"
            }
          }
        }

        patch "/recipes/#{recipe.id}", patch_params

        expect(flash[:danger]).to eq 'Wrong user!'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when no user is logged in" do
      let(:recipe) { create(:recipe) }

      it 'redirect back to login path' do
        get "/recipes/#{recipe.id}/edit"

        expect(flash[:danger]).to eq 'You must log in first.'
        expect(response).to redirect_to(login_path)
      end

      it 'redirect back to login path when updating a recipe' do
        patch_params = {
          params: {
            recipe: {
              title: recipe.title,
              description: "New description"
            }
          }
        }

        patch "/recipes/#{recipe.id}", patch_params

        expect(flash[:danger]).to eq 'You must log in first.'
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'Deleting a recipe' do
    context "when the recipe's user is the same as the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }

      it 'can delete the recipe' do
        request_log_in(user)

        delete "/recipes/#{recipe.id}"

        expect(response).to redirect_to('/')
      end
    end

    context "when the recipe's user is different then the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }

      let(:login_user) { create(:user) }

      it 'redirect back to root path' do
        request_log_in(login_user)

        delete "/recipes/#{recipe.id}"

        expect(flash[:danger]).to eq 'Wrong user!'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when no user is logged in" do
      let(:recipe) { create(:recipe) }

      it 'redirect back to login path' do
        delete "/recipes/#{recipe.id}"

        expect(flash[:danger]).to eq 'You must log in first.'
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
