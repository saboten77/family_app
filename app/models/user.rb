class User < ApplicationRecord
  belongs_to :family, optional: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :family_members
  has_many :families, through: :family_members
  validates :name, presence: true
end
