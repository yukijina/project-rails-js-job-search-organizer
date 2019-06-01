class Checklist < ApplicationRecord
  belongs_to :user
  belongs_to :position
  belongs_to :company


  def self.sort_by_resume
    Checklist.order(resume: :desc)
  end


end
