class InstructionsController < ApplicationController
  before_action :find_instruction, only: [ :edit, :update, :destroy]
  before_action :find_instruction_recipe, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [ :edit, :update]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build

    if logged_in?
      session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@recipe.user)
    end
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build(instruction_params)
    @instruction.user = current_user

    if @instruction.save
      flash[:info] = 'Added instruction step!'
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @instruction.update(instruction_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    if equal_with_current_user?(@recipe.user)
      @instruction.destroy
      flash[:info] = 'Deleted instruction step!'

      redirect_to @recipe
    else
      session_notice(:danger, 'Wrong user!')
    end
  end

  private

  def instruction_params
    params.require(:instruction).permit(:step)
  end

  def find_instruction
    @instruction = Instruction.find(params[:id])
  end

  def find_instruction_recipe
    @recipe = @instruction.recipe
  end

  def correct_user
    unless equal_with_current_user?(@instruction.recipe.user)
      flash[:danger] = 'Wrong user!'
      redirect_to(root_path)
    end
  end
end
