class ChecklistsController < ApplicationController

  def index
    @user = User.find_by(id: params[:user_id])
    @checklists = @user.checklists
    @companies = @user.companies
    @positions = @user.positions
    #binding.pry
  end

  def new
    @user = User.find_by(id: params[:user_id])
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @checklist = @user.checklists.build(checklist_params)

  end

  def show
    @user = User.find_by(id: params[:user_id])
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @checklist = Checklist.find_by(id: params[:id])

  end

  def update
    if params[:user_id]
      @checklist = Checklist.find_by(id: params[:id])
      if @checklist
        @checklist.update(checklist_params)
      # elsif @checklist.nil?
      #   @checklist = @user.checklists.build(checklist_params)
      #   @checklist.user_id = params[:user_id]
      #   @checklist.save
        redirect_to user_checklists_path(current_user)
      end
    end
  end

  private
    def checklist_params
      params.require(:checklist).permit(:resume, :interview, :completed, :note)
    end

end
