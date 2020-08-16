class IngredientsController < ApplicationController
  before_action :find_ingredient, only: [ :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
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
      flash[:info] = 'Added ingredient!'
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    @recipe = @ingredient.recipe
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
    recipe = @ingredient.recipe

    if equal_with_current_user?(recipe.user)
      @ingredient.destroy
      flash[:info] = 'Deleted ingredient!'

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

  def correct_user
    unless equal_with_current_user?(@ingredient.recipe.user)
      flash[:danger] = 'Wrong user!'
      redirect_to(root_path)
    end
  end
end
