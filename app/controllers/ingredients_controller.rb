class IngredientsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  # when showing a specific cocktail, also need to show the doses(&ingredients)
  def show
    set_cocktail
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
