class ChecklistsController < ApplicationController
  before_action :require_login

  def index
    @user = User.find_by(id: params[:user_id])
    if @user
      @checklists = @user.checklists
    else
      page_not_found
    end
  end

  def new
     @user = User.find_by(id: params[:user_id])
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @checklist = @user.checklists.build(checklist_params)
    @checklist.save
    redirect_to user_checklists_path(@user)
  end

  def show
    page_not_found
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @checklist = Checklist.find_by(id: params[:id])

  end

  def update
    if params[:user_id]
      @checklist = Checklist.find_by(id: params[:id])
      @checklist.update(checklist_params)
      redirect_to user_checklists_path(current_user)
    end
  end

  def destroy
    checklist = Checklist.find_by(id: params[:id])
    checklist.destroy
    redirect_to user_checklists_path(current_user)
  end

  private
    def checklist_params
      params.require(:checklist).permit(:resume, :interview, :completed, :note, :company_id, :user_id, :position_id)
    end

    def page_not_found
      flash[:message] = "Oops. Page not found."
      redirect_to user_checklists_path(current_user)
    end

end
