class PositionsController < ApplicationController
  before_action :require_login

  def index
    @company = Company.find_by(id: params[:company_id])
    @positions = @company.positions if @company
    @allpositions = Position.all
    if @company.nil?
      respond_to do |format|
        #need to create all positions page
        format.html { render :index}
        format.json { render json: @allpositions}
      end
    else
    @positions = @company.positions
      respond_to do |format|
        format.html { render :index}
        format.json { render json: @positions}
      end
    end
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new(position_params)

    if params[:position][:company_id]
      @position.company_id = params[:position][:company_id]
    end

    if @position.save
      render json: @position, status: 201
      #redirect_to company_positions_path(@position.company)
    else
      render :new
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
      params.require(:position).permit(:title, :description, :salary, :full_time, :company_id, :company_attributes => [:name, :url, :description])
    end

end
