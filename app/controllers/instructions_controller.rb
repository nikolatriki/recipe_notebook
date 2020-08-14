class InstructionsController < ApplicationController
  before_action :find_instruction, only: [ :edit, :update, :destroy]

  def new
    session_notice(:danger, 'You must be logged in to create ingredient!', login_path) unless logged_in?

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
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    session_notice(:danger, 'You must be logged in to edit instruction!', login_path) unless logged_in?

    @recipe = @instruction.recipe

    if logged_in?
      session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@recipe.user)
    end
  end

  def update
    @recipe = @instruction.recipe

    if @instruction.update(instruction_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    session_notice(:danger, 'You must be logged in!', login_path) unless logged_in?

    recipe = @instruction.recipe
    if equal_with_current_user?(recipe.user)
      @instruction.destroy
      flash[:info] = 'You have deleted an instruction step'

      redirect_to recipe
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
end
