class TaskLog < ApplicationRecord
  belongs_to :task
  belongs_to :family_member

  validates :completed_at, presence: true
end
