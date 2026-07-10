class Family < ApplicationRecord
  has_many :family_members
  has_many :users, through: :family_members
  
  validates :name, presence: true
  validates :invite_code, presence: true, uniqueness: true

  before_validation :generate_invite_code

  private

  def generate_invite_code
    self.invite_code ||= SecureRandom.alphanumeric(6).upcase
  end
end
