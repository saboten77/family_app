class Family < ApplicationRecord

  has_many :users

  before_create :generate_invite_code

  private

  def generate_invite_code
    self.invite_code = SecureRandom.alphanumeric(6).upcase
  end

end