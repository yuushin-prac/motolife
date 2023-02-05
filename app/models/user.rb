class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: { maximum: 32 }
  validates :email, {presence: true, uniqueness: { case_sensitive: false }}
  has_many :articles, dependent: :destroy
  attachment :profile_image
end
