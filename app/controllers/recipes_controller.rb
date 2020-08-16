class RecipesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order(created_at: :desc)
  end

  def show
    @ingredient = @recipe.ingredients
  end

  def new
    @recipe = Recipe.new

    5.times { @recipe.ingredients.build }
    5.times { @recipe.instructions.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      flash[:success] = 'New recipe!'

      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:info] = 'That recipe has been deleted!'

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

  def correct_user
    unless equal_with_current_user?(@recipe.user)
      flash[:danger] = 'Wrong user!'
      redirect_to(root_path)
    end
  end
end
