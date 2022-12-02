class User < ApplicationRecord
  ROLE = %w[buyer seller]
  has_many :products
  has_many :transactions
  has_many :reviews, through: :transactions
  # has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  validates :name, presence: true
  validates :city, presence: true
  validates :batch, presence: true
end
