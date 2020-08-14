class IngredientsController < ApplicationController
  def new
    session_notice(:danger, 'You must be logged in to create ingredient!', login_path) unless logged_in?
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.build
    if logged_in?
      session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@ingredient.user)
    end
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.build(ingredient_params)
    @ingredient.user = current_user

    if @ingredient.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    session_notice(:danger, 'You must be logged in to edit ingredient!', login_path) unless logged_in?
    @ingredient = Ingredient.find(params[:id])
    if logged_in?
      session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@ingredient.user)
    end
    @recipe = @ingredient.recipe
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @recipe = @ingredient.recipe

    if @ingredient.update(ingredient_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    session_notice(:danger, 'You must be logged in!', login_path) unless logged_in?
    ingredient = Ingredient.find(params[:id])
    if equal_with_current_user?(ingredient.user)
      ingredient.destroy

      redirect_to ingredient.recipe
    else
      session_notice(:danger, 'Wrong user!')
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:substance)
  end
end
