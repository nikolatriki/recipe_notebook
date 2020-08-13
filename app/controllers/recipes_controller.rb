class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order(created_at: :desc)
  end

  def show
    @ingredient = @recipe.ingredients
  end

  def new
    session_notice(:danger, 'You must log in first!') unless logged_in?
    @recipe = Recipe.new
    5.times { @recipe.ingredients.build }
    5.times { @recipe.instructions.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    session_notice(:danger, 'You must log in first!') unless logged_in?
    session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@recipe.user)

  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    session_notice(:danger, 'You must be logged in!') unless logged_in?
    session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@recipe.user)

    @recipe.destroy

    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit :title,
                                   :description,
                                   ingredients_attributes: [:id, :substance, :_destroy],
                                   instructions_attributes: [:id, :step, :_destroy]
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
