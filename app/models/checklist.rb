class Checklist < ApplicationRecord
  belongs_to :user
  belongs_to :position
  belongs_to :company

  def self.sort_by_resume
    order(resume: :desc)
  end

  def self.find_position(params)
    where(["user_id = ? AND position_id = ?", params[:user_id], params[:checklist][:position_id]]).first_or_initialize  do |checklist|
      checklist.user_id = params[:user_id]
      checklist.position_id = params[:checklist][:position_id]
      checklist.company_id = params[:checklist][:company_id]
    end
  end




end
