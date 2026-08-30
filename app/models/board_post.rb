class BoardPost < ApplicationRecord
  belongs_to :family_member

  validates :body, presence: true
end
