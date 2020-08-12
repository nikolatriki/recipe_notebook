class IngredientsController < ApplicationController
  def show
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.build(ingredient_params)

    if @ingredient.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
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
    ingredient = Ingredient.find_by(params[:id])
    recipe = ingredient.recipe

    ingredient.destroy
    redirect_to recipe
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:substance)
  end

end
