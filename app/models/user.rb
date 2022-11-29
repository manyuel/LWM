class User < ApplicationRecord
  ROLE = %w[buyer seller]
  has_many :product
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :city, presence: true
  validates :batch, presence: true
end
