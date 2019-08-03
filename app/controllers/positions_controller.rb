class PositionsController < ApplicationController
  before_action :require_login

  def index
    @company = Company.find_by(id: params[:company_id])
    if @company.nil?
      company_page_not_found
    else
      @positions = @company.positions
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @positions}
      end
    end
  end

  def new
    @company = Company.find_by(id: params[:company_id])
    @position = @company.positions.build
  end

  def create
    if @company = Company.find_by(id: params[:company_id])
      @position = @company.positions.build(position_params)

      if @company && @position.save
        current_user.checklists.create(company_id: @company.id, position_id: @position.id)
        redirect_to company_position_path(@company, @position)
      else
        render :new
      end
    end
  end

  def show
    @position = Position.find_by(id: params[:id])
    #company_page_not_found if @position.nil?
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @position }
    end
  end

  def edit
    @position = Position.find_by(id: params[:id])
  end

  def update
    @position = Position.find_by(id: params[:id])
    if @position.update(position_params)
      redirect_to company_position_path(@position.company, @position)
    else
      render :edit
    end
  end

  private
    def position_params
      params.require(:position).permit(:title, :description, :salary, :full_time, :company_id)
    end

end
