class CompaniesController < ApplicationController
  before_action :require_login

  def show
    @company = Company.find_by(id: params[:id])
    if @company
      redirect_to company_positions_path(@company)
    end
  end

  def new
    @company = Company.new
    @company.positions.build
  end

  def create
    if params[:company][:id]
      @company = Company.find_by(id: params[:company][:id])
      redirect_to new_company_position_path(@company)
    else
      @company = Company.new(company_params)
      @position = @company.positions.last
      if @company.save
        current_user.checklists.create(company_id: @company.id, position_id: @position.id)
        redirect_to company_position_path(@company, @position)
      else
        render "new"
      end
    end
  end

  def edit
    @company = Company.find_by(id: params[:id])
  end

  def update
    @company = Company.find_by(id: params[:id])
    @company.update(company_params)
    #redirect_to company_path(@company)
  end

  private
    def company_params
      params.require(:company).permit(:name, positions_attributes: [:title, :description, :salary, :full_time])
    end


end
