class ChecklistsController < ApplicationController

  def index
    @user = User.find_by(id: params[:user_id])
    @companies = @user.companies
    @positions = @user.positions
    @checklists = @user.checklists
  end

  def new
    @user = User.find_by(id: params[:user_id])
  end

  def create
    binding.pry
    @user = User.find_by(id: params[:user_id])
    @checklist = @user.checklists.build(checklist_params)

  end

  def edit

  end

  def update
    if params[:position_id]
      @checklist = Checklist.find_by(id: params[:checklist][:id])
      if @checklist
        @checklist.update(checklist_params)
      elsif @checklist.nil?
        @checklist = @user.checklists.build(checklist_params)
        @checklist.position_id = params[:position_id]
        @checklist.save
        render 'index'
      end
    end
  end

  private
    def checklist_params
      params.require(:checklist).permit(:resume, :interview, :completed)
    end

end
