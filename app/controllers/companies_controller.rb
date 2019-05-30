class CompaniesController < ApplicationController
  before_action :require_login
  
  def index
    @companies = current_user.companies
  end

  def new
    @company = Company.new
  end

  def create
    if params[:company][:id]
      @company = Company.find_by(id: params[:company][:id])
      redirect_to new_company_position_path(@company)
    else
      @company = Company.new(company_params)
      @company.save
      redirect_to company_path(@company)
    end
  end

  def show
    @company = Company.find_by(id: params[:id])
  end

  def edit
    @company = Company.find_by(id: params[:id])
  end

  def update
    @company = Company.find_by(id: params[:id])
    @company.update(company_params)
    redirect_to company_path(@company)
  end

  private
    def company_params
      params.require(:company).permit(:name, :city, :contact_person, :email, :phone_number)
    end

# permit(position: [:title, :description, :salary, :full_time])


end
