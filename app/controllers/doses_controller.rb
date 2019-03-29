class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id]) # for creating the form in view
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_param)
    @dose.cocktail = @cocktail

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_param
    params.require(:dose).permit(:description, :ingredient_id)
  end

end
