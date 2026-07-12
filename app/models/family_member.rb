class FamilyMember < ApplicationRecord
  belongs_to :family
  belongs_to :user

  has_many :task_logs
end
