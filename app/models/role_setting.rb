class RoleSetting < ApplicationRecord
  belongs_to :family_member

  validates :percentage,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 100
            }
end
