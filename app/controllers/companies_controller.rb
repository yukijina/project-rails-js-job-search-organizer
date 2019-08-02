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
      params.require(:company).permit(:name, :url, positions_attributes: [:title, :description, :salary, :full_time])
    end

end
