class IngredientsController < ApplicationController
  before_action :find_ingredient, only: [ :edit, :update, :destroy]

  def new
    session_notice(:danger, 'You must be logged in to create ingredient!', login_path) unless logged_in?

    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.build

    if logged_in?
      session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@recipe.user)
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

    @recipe = @ingredient.recipe

    if logged_in?
      session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@recipe.user)
    end
  end

  def update
    @recipe = @ingredient.recipe

    if @ingredient.update(ingredient_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    session_notice(:danger, 'You must be logged in!', login_path) unless logged_in?

    recipe = @ingredient.recipe

    if equal_with_current_user?(recipe.user)
      @ingredient.destroy
      flash[:info] = 'You have deleted an ingredient'

      redirect_to recipe
    else
      session_notice(:danger, 'Wrong user!')
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:substance)
  end

  def find_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end
