class InstructionsController < ApplicationController
  def new
    session_notice(:danger, 'You must be logged in to create ingredient!', login_path) unless logged_in?
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build
    if logged_in?
      session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@instruction.user)
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
    @instruction = Instruction.find(params[:id])
    if logged_in?
      session_notice(:danger, 'Wrong user!') unless equal_with_current_user?(@instruction.user)
    end
    @recipe = @instruction.recipe
  end

  def update
    @instruction = Instruction.find(params[:id])
    @recipe = @instruction.recipe

    if @instruction.update(instruction_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    session_notice(:danger, 'You must be logged in!', login_path) unless logged_in?
    instruction = Instruction.find(params[:id])
    if equal_with_current_user?(instruction.user)
    instruction.destroy

    redirect_to instruction.recipe
    else
      session_notice(:danger, 'Wrong user!')
    end
  end

  private

  def instruction_params
    params.require(:instruction).permit(:step)
  end
end
