class Family < ApplicationRecord
  validates :name, presence: true
  validates :invite_code, presence: true, uniqueness: true

  before_validation :generate_invite_code

  private

  def generate_invite_code
    self.invite_code ||= SecureRandom.alphanumeric(6).upcase
  end
end