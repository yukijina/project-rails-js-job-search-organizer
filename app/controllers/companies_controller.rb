class CompaniesController < ApplicationController
  before_action :require_login

  def index
    @companies = Company.sort_by_name
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @companies }
    end
  end

  def show
    @company = Company.find_by(id: params[:id])
    if @company.nil?
      company_page_not_found
    else
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @company }
      end
      #redirect_to company_positions_path(@company)
    end
  end

  def edit
    if current_user.admin?
      @company = Company.find_by(id: params[:id])
    else
      flash[:message] = "Only admin can edit the company."
      redirect_to companies_path
    end
  end

  def update
    company = Company.find_by(id: params[:id])
    company.update(company_params)
    redirect_to company_path(company)
  end

  private
    def company_params
      params.require(:company).permit(:name, :url, :description, positions_attributes: [:title, :description, :salary, :full_time])
    end

end
