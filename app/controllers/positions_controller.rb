class PositionsController < ApplicationController

  def new
    @company = Company.find_by(id: params[:company_id])
    @position = Position.new
  end

  def create
    @position = Position.new(position_params)
    binding.pry
    if @position && @position.save
      redirect_to company_position_path(@position.company, @position)
    end
  end

  private
    def position_params
      params.require(:position).permit(:title, :description, :salary, :full_time, :comapny_id)
    end

end
