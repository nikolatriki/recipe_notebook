class InstructionsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build(instruction_params)

    if @instruction.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    @instruction = Instruction.find(params[:id])
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
    instruction = Instruction.find(params[:id])
    instruction.destroy

    redirect_to instruction.recipe
  end

  private

  def instruction_params
    params.require(:instruction).permit(:step)
  end
end
