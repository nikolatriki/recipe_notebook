require 'rails_helper'

RSpec.describe 'Instructions' do
  let(:recipe) { create(:recipe) }
  let(:instruction) { create(:instruction, recipe: recipe) }

  describe 'Edit recipe instructions' do
    context 'when no user is signed in' do
      it 'redirect back to login path' do
        get edit_recipe_instruction_path(recipe, instruction)

        expect(response).to redirect_to(login_path)
      end

      it 'redirect back to login path using patch HTTP verb' do
        patch_params = {
          params: {
            instruction: {
              step: 'New step'
            }
          }
        }

        patch recipe_instruction_path(recipe, instruction), patch_params

        expect(response).to redirect_to(login_path)
      end
    end

    context 'when a user is signed in' do
      let(:user) { create(:user) }
      let(:user_instruction) { create(:instruction, user: user) }

      before { request_log_in(user) }

      it 'cannot edit different user instructions' do
        patch_params = {
          params: {
            instruction: {
              step: 'New step'
            }
          }
        }

        patch recipe_instruction_path(recipe, instruction), patch_params

        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq 'Wrong user!'
      end

      it 'is able to edit a instruction' do
        patch_params = {
          params: {
            instruction: {
              step: 'MyText'
            }
          }
        }

        patch recipe_instruction_path(user_instruction.recipe, user_instruction), patch_params

        expect(user_instruction.reload.step).to eq 'MyText'
      end
    end
  end

  describe 'Creating an recipe instruction' do
    context 'when no user is signed in' do
      it 'redirects to login' do
        post_params = {
          params: {
            instruction: {
              step: 'New step'
            }
          }
        }

        post recipe_instructions_path(recipe), post_params

        expect(response).to redirect_to(login_path)
      end
    end

    context 'when a user is sign in' do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }

      before { request_log_in(user) }

      it 'can create a instruction' do
        post_instruction_params = {
          params: {
            instruction: {
              step: 'New step'
            }
          }
        }

        expect do
          post recipe_instructions_path(recipe), post_instruction_params
        end.to change { Instruction.count }
      end
    end
  end

  describe 'Deleting an recipe instruction' do
    context 'when no user is signed in' do
      it 'redirect back when deleting a instruction' do
        delete recipe_instruction_path(recipe, instruction)

        expect(response).to redirect_to(login_path)
      end
    end

    context 'when a user is sign in' do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }
      let(:instruction) { create(:instruction, user: user, recipe: recipe) }

      let(:different_user) { create(:user) }
      let(:different_instruction) { create(:instruction, user: different_user) }

      before { request_log_in(user) }

      it 'can delete its own recipe instruction' do
        delete recipe_instruction_path(recipe, instruction)

        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'cannot delete different user instruction on a different user recipe' do
        delete recipe_instruction_path(recipe, different_instruction)

        expect(flash[:danger]).to eq 'Wrong user!'
        expect(response).to redirect_to(root_path)
      end

      it 'can delete different user instructions on its own recipe' do
        recipe.instructions << different_instruction

        delete recipe_instruction_path(recipe, different_instruction)

        expect(response).to redirect_to(recipe_path(recipe))
      end
    end
  end
end
