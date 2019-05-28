class CompaniesController < ApplicationController

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.save
    current_user.companies << @company
    redirect_to company_path(@company)
  end

  def show
    @company = Company.find_by(id: params[:id])
  end

  private
    def company_params
      params.require(:company).permit(:name, :city, :contact_person, :email, :phone_number)
    end

# permit(position: [:title, :description, :salary, :full_time])


end
