class PositionsController < ApplicationController
  #skip_before_action :verify_authenticity_token
  before_action :require_login

  def index
    @company = Company.find_by(id: params[:company_id])
    if @company.nil?
      redirect_to companies_path
    else
    @positions = @company.positions
      respond_to do |format|
        format.html { render :index}
        format.json { render json: @positions}
      end
    end
  end

  def all_index
    @positions = Position.sort_by_title
    respond_to do |format|
      format.html { render :all_index }
      format.json { render json: @positions }
    end
  end

  def new
    @position = Position.new
  end

  def create
    #binding.pry
    @position = Position.new(position_params)

    if params[:position][:company_id]
      @position.company_id = params[:position][:company_id]
    end

    if @position.save
      respond_to do |format|
        format.html { redirect_to company_position_path(@position.company, @position) }
        format.json { render json: @position}
      end
    else
      render :new
    end
  end

  def show
    @position = Position.find_by(id: params[:id])
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
    if params[:position][:company_attributes][:name].empty?
       @position.update(title: params[:position][:title], description:  params[:position][:description], salary:  params[:position][:salary], full_time:  params[:position][:full_time], company_id: params[:position][:company_id])
      redirect_to company_position_path(@position.company, @position)
    elsif !params[:position][:company_attributes][:name].empty?
      @position.update(position_params)
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
