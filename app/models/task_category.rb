class TaskCategory < ApplicationRecord
  validates :name, presence: true
end