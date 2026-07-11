class Task < ApplicationRecord
  belongs_to :task_category

  validates :name, presence: true
end
