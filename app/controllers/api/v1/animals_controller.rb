class Api::V1::AnimalsController < ApplicationController

  def index
    render json: Animal.all
  end

  def show
    render json: Animal.find(params[:id])
  end

  def create
    render json: Animal.create(animal_params)
  end

  def update
    render json: Animal.update(params[:id], animal_params)
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :breed)
  end
end
